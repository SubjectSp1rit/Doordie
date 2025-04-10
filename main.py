import os
from dotenv import load_dotenv
import asyncio
from email.mime.text import MIMEText
import aiosmtplib
from typing import Optional, List
from fastapi import FastAPI, Depends, HTTPException, Header
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base, relationship
from sqlalchemy import Column, Integer, String, select, text, DateTime, delete, Boolean, Table, ForeignKey
from jose import jwt
from datetime import datetime, timedelta


# Настройка JWT
JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY")
JWT_ALGORITHM = os.getenv("JWT_ALGORITHM")
JWT_EXPIRE_MINUTES = int(os.getenv("JWT_EXPIRE_MINUTES"))

# URL подключения к базе данных из переменных окружения

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

DATABASE_URL = os.getenv(
    "DATABASE_URL",
    f"postgresql+asyncpg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

engine = create_async_engine(DATABASE_URL, echo=True)
async_session = sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)
Base = declarative_base()


# Модели данных
class Habit(Base):
    __tablename__ = "habits"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    user_id = Column(Integer)
    creation_date = Column(String)
    title = Column(String)
    motivations = Column(String)
    color = Column(String)
    icon = Column(String)
    quantity = Column(String)
    current_quantity = Column(String)
    measurement = Column(String)
    regularity = Column(String)
    day_part = Column(String)

class HabitExecution(Base):
    __tablename__ = "habit_executions"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    habit_id = Column(Integer, nullable=False)
    user_id = Column(Integer, nullable=False)
    current_quantity = Column(String, nullable=False, default="0")
    execution_date = Column(String, nullable=False)

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    email = Column(String, unique=True, index=True)
    name = Column(String)
    password = Column(String)

class Friendship(Base):
    __tablename__ = "friendships"
    user_id = Column(Integer, primary_key=True)
    friend_id = Column(Integer, primary_key=True)

class Token(Base):
    __tablename__ = "tokens"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    user_id = Column(Integer)
    token = Column(String, unique=True, index=True)

# Модель для создания новой привычки (используется в POST)
class HabitCreate(BaseModel):
    creation_date: Optional[str] = None
    title: Optional[str] = None
    motivations: Optional[str] = None
    color: Optional[str] = None
    icon: Optional[str] = None
    quantity: Optional[str] = None
    current_quantity: Optional[str] = None
    measurement: Optional[str] = None
    regularity: Optional[str] = None
    day_part: Optional[str] = None

# Модель для обновления привычки (используется в PUT)
class HabitUpdate(BaseModel):
    id: int
    creation_date: Optional[str] = None
    title: Optional[str] = None
    motivations: Optional[str] = None
    color: Optional[str] = None
    icon: Optional[str] = None
    quantity: Optional[str] = None
    current_quantity: Optional[str] = None
    measurement: Optional[str] = None
    regularity: Optional[str] = None
    day_part: Optional[str] = None

class HabitExecutionUpdate(BaseModel):
    id: int
    user_id: int
    creation_date: Optional[str] = None
    title: Optional[str] = None
    motivations: Optional[str] = None
    color: Optional[str] = None
    icon: Optional[str] = None
    quantity: Optional[str] = None
    current_quantity: Optional[str] = None
    measurement: Optional[str] = None
    regularity: Optional[str] = None
    day_part: Optional[str] = None

# Модель для удаления привычки (используется в DELETE)
class HabitDelete(BaseModel):
    id: int
    creation_date: Optional[str] = None
    title: Optional[str] = None
    motivations: Optional[str] = None
    color: Optional[str] = None
    icon: Optional[str] = None
    quantity: Optional[str] = None
    current_quantity: Optional[str] = None
    measurement: Optional[str] = None
    regularity: Optional[str] = None
    day_part: Optional[str] = None

# Модель для создания пользователя (используется в POST)
class UserCreate(BaseModel):
    email: str
    name: str
    password: str

# Модель для аутентификации пользователя (используется в POST)
class UserLogin(BaseModel):
    email: Optional[str] = None
    name: Optional[str] = None
    password: Optional[str] = None

class EmailCheck(BaseModel):
    email: str

# Модель для аутентификации пользователя (используется в POST как возвращаемое значение)
class TokenResponse(BaseModel):
    token: str
    name: str

# Модель для ответа на запрос аутентификации (используется в POST как возвращаемое значение)
class LoginResponse(BaseModel):
    token: str
    name: str
    is_success: bool

# Модель для ответа на запрос удаления привычки (используется в DELETE как возвращаемое значение)
class DeleteHabitResponse(BaseModel):
    detail: str


# Модель для ответа на запрос обновления привычки (используется в PUT как возвращаемое значение)
class UpdateHabitResponse(BaseModel):
    detail: str


class CreateHabitResponse(BaseModel):
    detail: str


class FriendUserModel(BaseModel):
    email: str
    name: str

class GetFriendsResponse(BaseModel):
    friends: List[FriendUserModel]
    detail: str

class AddFriendResponse(BaseModel):
    detail: str

class DeleteFriendResponse(BaseModel):
    detail: str

class EmailMessageRequest(BaseModel):
    email: str
    subject: str
    message: str

class EmailMessageResponse(BaseModel):
    detail: str

class HabitExecutionData(BaseModel):
    execution_date: str

class HabitAnalytics(BaseModel):
    id: int
    title: str
    icon: str
    color: str
    executions: List[HabitExecutionData]

class HabitAnalyticsResponse(BaseModel):
    data: List[HabitAnalytics]
    detail: str


# Создает JWT-токен с указанным временем жизни
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=JWT_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, JWT_SECRET_KEY, algorithm=JWT_ALGORITHM)
    return encoded_jwt

class TokenModel(BaseModel):
    token: Optional[str] = None

app = FastAPI()


@app.on_event("startup")
async def startup():
    max_retries = 10
    for attempt in range(max_retries):
        try:
            async with engine.begin() as conn:
                await conn.execute(text("SELECT 1"))
            print("Подключение к БД установлено")
            break
        except Exception as e:
            print(f"Попытка {attempt + 1}/{max_retries} не удалась: {e}")
            await asyncio.sleep(1)
    else:
        raise Exception("База данных недоступна после нескольких попыток подключения")

    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)


# Зависимость для получения сессии БД
async def get_db():
    async with async_session() as session:
        yield session


@app.get("/")
async def read_root():
    return {"message": "Hello, world!"}


@app.post("/friends", response_model=AddFriendResponse)
async def add_friend(
    friend_email: EmailCheck,
    token: str = Header(None, alias="Token"),
    db: AsyncSession = Depends(get_db)
):
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Получаем текущего пользователя по токену
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()
    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")
    current_user_id = token_record.user_id

    # Ищем пользователя-друга по email
    friend_result = await db.execute(select(User).where(User.email == friend_email.email))
    friend_user = friend_result.scalars().first()
    if not friend_user:
        raise HTTPException(status_code=404, detail="Friend not found")

    # Запрещаем добавлять себя в друзья
    if friend_user.id == current_user_id:
        raise HTTPException(status_code=400, detail="You cannot add yourself as a friend")

    # Проверяем, существует ли уже дружба для текущего пользователя
    friendship_check = await db.execute(
        select(Friendship).where(
            Friendship.user_id == current_user_id,
            Friendship.friend_id == friend_user.id
        )
    )
    if friendship_check.first():
        raise HTTPException(status_code=400, detail="Friendship already exists")

    await db.execute(
        Friendship.__table__.insert().values([
            {"user_id": current_user_id, "friend_id": friend_user.id},
            {"user_id": friend_user.id, "friend_id": current_user_id}
        ])
    )
    await db.commit()

    return AddFriendResponse(detail="Friend successfully added")


@app.get("/friends", response_model=GetFriendsResponse)
async def get_friends(
        token: str = Header(None, alias="Token"),
        db: AsyncSession = Depends(get_db)
):
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Получаем токен и извлекаем user_id текущего пользователя
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()
    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")
    current_user_id = token_record.user_id

    # Запрашиваем список идентификаторов друзей из таблицы friendships
    friends_result = await db.execute(
        select(Friendship.friend_id).where(Friendship.user_id == current_user_id)
    )
    friend_ids = friends_result.scalars().all()

    # Если друзей нет, возвращаем пустой список
    if not friend_ids:
        return GetFriendsResponse(friends=[], detail="No friends found")

    # Получаем данные пользователей по списку идентификаторов
    users_result = await db.execute(select(User).where(User.id.in_(friend_ids)))
    friend_users = users_result.scalars().all()

    friend_list = [FriendUserModel(email=user.email, name=user.name) for user in friend_users]

    return GetFriendsResponse(friends=friend_list, detail="Friends retrieved successfully")


@app.delete("/friends", response_model=DeleteFriendResponse)
async def delete_friend(
        email_check: EmailCheck,
        token: str = Header(None, alias="Token"),
        db: AsyncSession = Depends(get_db)
):
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Получаем текущего пользователя по токену
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()
    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")
    current_user_id = token_record.user_id

    # Ищем пользователя-друга по email
    friend_result = await db.execute(select(User).where(User.email == email_check.email))
    friend_user = friend_result.scalars().first()
    if not friend_user:
        raise HTTPException(status_code=404, detail="Friend not found")
    friend_user_id = friend_user.id

    # Удаляем обе записи дружбы: (current_user, friend) и (friend, current_user)
    delete_stmt1 = delete(Friendship).where(
        Friendship.user_id == current_user_id,
        Friendship.friend_id == friend_user_id
    )
    delete_stmt2 = delete(Friendship).where(
        Friendship.user_id == friend_user_id,
        Friendship.friend_id == current_user_id
    )
    await db.execute(delete_stmt1)
    await db.execute(delete_stmt2)
    await db.commit()

    return DeleteFriendResponse(detail="Friend successfully deleted")


@app.post("/send_email")
async def send_email(email_request: EmailMessageRequest):
    # Формируем MIME-сообщение
    msg = MIMEText(email_request.message, "plain", "utf-8")
    msg["From"] = os.getenv("SMTP_FROM")
    msg["To"] = email_request.email
    msg["Subject"] = email_request.subject

    smtp_host = os.getenv("SMTP_HOST")
    smtp_port = int(os.getenv("SMTP_PORT"))
    smtp_user = os.getenv("SMTP_USER")
    smtp_password = os.getenv("SMTP_PASSWORD")

    try:
        await aiosmtplib.send(
            msg,
            hostname=smtp_host,
            port=smtp_port,
            username=smtp_user,
            password=smtp_password,
            start_tls=True
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Email sending failed: {str(e)}")

    return EmailMessageResponse(detail="Email sent successfully")


# GET-эндпоинт для получения всех привычек пользователя
@app.get("/habits")
async def get_habits(
        token: str = Header(None, alias="Token"),
        date: str = Header(None, alias="Date"),
        db: AsyncSession = Depends(get_db)):
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Поиск токена и получение user_id
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()
    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")

    # Получаем все привычки пользователя
    result = await db.execute(select(Habit).where(Habit.user_id == token_record.user_id))
    habits = result.scalars().all()

    # Получаем записи HabitExecution за переданную дату
    executions_result = await db.execute(
        select(HabitExecution).where(
            HabitExecution.user_id == token_record.user_id,
            HabitExecution.execution_date == date
        )
    )
    habit_executions = executions_result.scalars().all()

    executions_by_habit = {execution.habit_id: execution for execution in habit_executions}

    # Если для какой-то привычки не существует записи HabitExecution за текущую дату, создаем её
    for habit in habits:
        if habit.id not in executions_by_habit:
            new_execution = HabitExecution(
                habit_id=habit.id,
                user_id=habit.user_id,
                current_quantity=habit.current_quantity if habit.current_quantity is not None else "0",
                execution_date=date
            )
            db.add(new_execution)

            await db.flush()
            executions_by_habit[habit.id] = new_execution

    await db.commit()

    # Формируем итоговый ответ, объединяя данные из Habit и состояние выполнения из HabitExecution
    response = []
    for habit in habits:
        exec_record = executions_by_habit.get(habit.id)
        response.append({
            "id": habit.id,
            "user_id": habit.user_id,
            "creation_date": habit.creation_date,
            "title": habit.title,
            "motivations": habit.motivations,
            "color": habit.color,
            "icon": habit.icon,
            "quantity": habit.quantity,
            "current_quantity": exec_record.current_quantity if exec_record else habit.current_quantity,
            "measurement": habit.measurement,
            "regularity": habit.regularity,
            "day_part": habit.day_part
        })
    return response


@app.put("/habit_execution")
async def update_habit_execution(
        habit_update: HabitExecutionUpdate,
        date: str = Header(None, alias="Date"),
        token: str = Header(None, alias="Token"),
        db: AsyncSession = Depends(get_db)
):
    # Проверка наличия токена
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Проверяем валидность токена и получаем user_id
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()
    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")

    # Убедимся, что переданный user_id соответствует токену
    if habit_update.user_id != token_record.user_id:
        raise HTTPException(status_code=403, detail="Нет прав доступа")

    # Находим запись в таблице habit_executions по habit_id, user_id и execution_date (из заголовка Date)
    query = select(HabitExecution).where(
        HabitExecution.habit_id == habit_update.id,
        HabitExecution.user_id == habit_update.user_id,
        HabitExecution.execution_date == date
    )
    result = await db.execute(query)
    habit_execution = result.scalars().first()

    if not habit_execution:
        raise HTTPException(status_code=404, detail="Запись выполнения привычки не найдена")

    if habit_update.current_quantity is not None:
        habit_execution.current_quantity = habit_update.current_quantity
    else:
        raise HTTPException(status_code=400, detail="Поле current_quantity обязательно для обновления")

    await db.commit()

    return {"detail": "Запись выполнения привычки успешно обновлена"}


# POST-эндпоинт для создания новой привычки через тело запроса (JSON)
@app.post("/habits", response_model=CreateHabitResponse)
async def create_habit(
    habit_data: HabitCreate,
    token: str = Header(None, alias="Token"),
    db: AsyncSession = Depends(get_db)
):
    # Проверяем наличие токена
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Находим токен в базе данных
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()

    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")

    # Создаем новую привычку
    new_habit = Habit(
        user_id=token_record.user_id,
        creation_date=habit_data.creation_date,
        title=habit_data.title,
        motivations=habit_data.motivations,
        color=habit_data.color,
        icon=habit_data.icon,
        quantity=habit_data.quantity,
        current_quantity=habit_data.current_quantity,
        measurement=habit_data.measurement,
        regularity=habit_data.regularity,
        day_part=habit_data.day_part,
    )

    db.add(new_habit)
    await db.commit()

    return CreateHabitResponse(detail="Habit successfully created")


# PUT-эндпоинт для обновления данных о привычке
@app.put("/habits", response_model=UpdateHabitResponse)
async def update_habit(
        habit_update: HabitUpdate,
        token: str = Header(None, alias="Token"),
        db: AsyncSession = Depends(get_db)
):
    # Проверяем наличие токена
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Находим токен в базе данных
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()

    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")

    # Получаем user_id из токена
    user_id = token_record.user_id

    # Поиск привычки по id
    result = await db.execute(select(Habit).where(Habit.id == habit_update.id))
    habit = result.scalars().first()
    if habit is None:
        raise HTTPException(status_code=404, detail="Привычка не найдена")

    # Проверяем, принадлежит ли привычка пользователю с полученным user_id
    if habit.user_id != user_id:
        raise HTTPException(status_code=403, detail="У вас нет прав на изменение этой привычки")

    update_data = habit_update.dict(exclude_unset=True)
    update_data.pop("id", None)
    for key, value in update_data.items():
        setattr(habit, key, value)

    await db.commit()
    await db.refresh(habit)

    return UpdateHabitResponse(detail="Привычка успешно обновлена")


@app.delete("/habits", response_model=DeleteHabitResponse)
async def delete_habit(
        habit_data: HabitDelete,
        token: str = Header(None, alias="Token"),
        db: AsyncSession = Depends(get_db)):
    # Проверяем наличие токена
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    # Находим токен в базе данных
    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()

    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")

    # Получаем user_id из токена
    user_id = token_record.user_id

    if habit_data.id is None:
        raise HTTPException(status_code=400, detail="Поле 'id' обязательно для удаления привычки")

    result = await db.execute(select(Habit).where(Habit.id == habit_data.id))
    habit = result.scalars().first()

    if habit is None:
        raise HTTPException(status_code=404, detail="Привычка не найдена")

    # Проверяем, принадлежит ли привычка пользователю с полученным user_id
    if habit.user_id != user_id:
        raise HTTPException(status_code=403, detail="У вас нет прав на удаление этой привычки")

    # Удаляем привычку
    await db.execute(delete(Habit).where(Habit.id == habit_data.id))
    await db.commit()

    return DeleteHabitResponse(detail="Привычка успешно удалена")


# POST-эндпоинт для создания пользователя и генерации токена
@app.post("/register", response_model=TokenResponse)
async def create_user(user_create: UserCreate, db: AsyncSession = Depends(get_db)):
    # Проверяем, существует ли пользователь с таким email
    result = await db.execute(select(User).where(User.email == user_create.email))
    existing_user = result.scalars().first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Пользователь с таким email уже существует.")

    new_user = User(
        email=user_create.email,
        name=user_create.name,
        password=user_create.password
    )
    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)

    # Генерируем JWT-токен
    token_data = {"sub": new_user.email, "user_id": new_user.id}
    token_value = create_access_token(token_data)

    new_token = Token(
        user_id=new_user.id,
        token=token_value
    )

    db.add(new_token)
    await db.commit()
    await db.refresh(new_token)

    return TokenResponse(token=str(new_token.token), name=str(new_user.name))

# POST-эндпоинт для аутентификации пользователя
@app.post("/login", response_model=LoginResponse)
async def login_user(user_login: UserLogin, db: AsyncSession = Depends(get_db)):
    # Ищем пользователя по email
    result = await db.execute(select(User).where(User.email == user_login.email))
    user = result.scalars().first()

    # Проверяем совпадает ли пароль
    if user and user.password == user_login.password:
        # Ищем токен по user_id
        token_result = await db.execute(select(Token).where(Token.user_id == user.id))
        token_record = token_result.scalars().first()

        if token_record:
            return LoginResponse(token=str(token_record.token), name=str(user.name), is_success=True)
        else:
            return LoginResponse(token="", name="", is_success=False)
    else:
        # Пароль не совпадает
        return LoginResponse(token="", name="", is_success=False)

# POST-эндпоинт проверки существования email в базе данных
@app.post("/emails")
async def check_email_exists(email_check: EmailCheck, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(User).where(User.email == email_check.email))
    existing_user = result.scalars().first()
    return {"is_exists": existing_user is not None}


@app.get("/habit_analytics", response_model=HabitAnalyticsResponse)
async def get_habit_analytics(
        token: str = Header(None, alias="Token"),
        date: str = Header(None, alias="Date"),
        db: AsyncSession = Depends(get_db)
):
    if not token:
        raise HTTPException(status_code=401, detail="Token header is required")

    token_result = await db.execute(select(Token).where(Token.token == token))
    token_record = token_result.scalars().first()
    if not token_record:
        raise HTTPException(status_code=401, detail="Invalid token")
    user_id = token_record.user_id

    habits_result = await db.execute(select(Habit).where(Habit.user_id == user_id))
    habits = habits_result.scalars().all()

    try:
        current_date = datetime.strptime(date, "%d.%m.%Y")
    except ValueError:
        raise HTTPException(status_code=400, detail="Invalid date format. Use dd.MM.yyyy")

    date_list = [(current_date - timedelta(days=i)).strftime("%d.%m.%Y") for i in range(7)]

    habit_analytics = []

    for habit in habits:
        executions_result = await db.execute(
            select(HabitExecution).where(
                HabitExecution.habit_id == habit.id,
                HabitExecution.user_id == user_id,
                HabitExecution.execution_date.in_(date_list)
            )
        )
        execution_records = executions_result.scalars().all()

        executions_by_date = {record.execution_date: record for record in execution_records}

        matching_executions = []
        for date_str in date_list:
            execution = executions_by_date.get(date_str)
            if execution and execution.current_quantity == habit.quantity:
                matching_executions.append(
                    HabitExecutionData(
                        execution_date=date_str
                    )
                )

        habit_analytics.append(
            HabitAnalytics(
                id=habit.id,
                title=habit.title,
                icon=habit.icon,
                color=habit.color,
                executions=matching_executions
            )
        )

    return HabitAnalyticsResponse(data=habit_analytics, detail="Habits analytics successfully retrieved")
