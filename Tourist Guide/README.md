# 🗺️ India Tourist Guide — Java Web Application — Web Application
## Java Servlets + JSP + JDBC + MySQL | Academic Project

---

## Project Structure

```
TouristGuide/
├── pom.xml                          ← Maven build file
├── setup.sql                        ← Run this in MySQL first
└── src/main/
    ├── java/
    │   ├── db/
    │   │   └── DBConnection.java    ← JDBC connection
    │   ├── model/
    │   │   ├── City.java            ← JavaBean
    │   │   ├── Place.java           ← JavaBean
    │   │   └── Product.java         ← JavaBean
    │   ├── dao/
    │   │   ├── CityDAO.java         ← JDBC queries
    │   │   ├── PlaceDAO.java        ← JDBC + Streams
    │   │   └── ProductDAO.java      ← JDBC queries
    │   ├── servlet/
    │   │   ├── HomeServlet.java     ← Homepage controller
    │   │   └── CityServlet.java     ← City detail controller
    │   └── filter/
    │       └── LogFilter.java       ← Request logger
    └── webapp/
        ├── redirect.jsp             ← Welcome redirect
        ├── css/
        │   └── style.css
        └── WEB-INF/
            ├── web.xml
            ├── index.jsp            ← Homepage view
            ├── city.jsp             ← City detail view
            └── error.jsp            ← Error page
```

---

## Java Concepts Covered

| Concept | Where Used |
|---|---|
| JDBC | DBConnection, all DAOs |
| Servlets | HomeServlet, CityServlet |
| JSP + JSTL | index.jsp, city.jsp |
| JavaBeans | City, Place, Product models |
| DAO Pattern | CityDAO, PlaceDAO, ProductDAO |
| Java Filter | LogFilter |
| Collections (List, ArrayList) | All DAOs |
| Stream API | PlaceDAO.getPlacesSortedByFee() |
| Exception Handling | try-with-resources in all DAOs |
| HTTP Session | Last visited city tracking |
| PreparedStatement | All parameterised queries |

---

## Setup Instructions

### Step 1 — Install Requirements
- JDK 17+ → https://adoptium.net
- MySQL 8+ → https://dev.mysql.com/downloads/
- Apache Tomcat 10+ → https://tomcat.apache.org
- Maven 3.8+ → https://maven.apache.org
- IntelliJ IDEA (recommended) or Eclipse

### Step 2 — Set Up the Database
Open MySQL Workbench or terminal:
```bash
mysql -u root -p < setup.sql
```
Or paste the contents of setup.sql into MySQL Workbench and run it.

### Step 3 — Configure DB Password
Open `src/main/java/db/DBConnection.java` and change:
```java
private static final String PASSWORD = "your_password";
```
to your actual MySQL root password.

### Step 4 — Build the Project
```bash
cd TouristGuide
mvn clean package
```
This creates `target/TouristGuide-1.0.war`

### Step 5 — Deploy to Tomcat
**Option A — Copy WAR file:**
Copy `target/TouristGuide-1.0.war` to your Tomcat `webapps/` folder.
Start Tomcat: `bin/startup.sh` (Linux/Mac) or `bin/startup.bat` (Windows)

**Option B — Run via Maven (easier for development):**
```bash
mvn tomcat7:run
```

### Step 6 — Open in Browser
```
http://localhost:8080/TouristGuide
```

---

## How It Works (Request Flow)

```
Browser → HTTP Request
       → Tomcat receives it
       → LogFilter logs the request
       → HomeServlet / CityServlet handles it
       → DAO queries MySQL via JDBC
       → Data set as request attributes
       → JSP renders HTML with JSTL
       → HTML response sent to browser
```

---

## Features

- **Homepage** — City grid with theme badges, search by name/theme
- **City Detail** — History, Popular Places, Fair Prices in 3 tabs
- **Sort Places** — Sort by name or entry fee (Java Stream API)
- **Session Memory** — Remembers last visited city (HttpSession)
- **Request Logging** — Every page visit logged (Java Filter)
- **Anti-overcharge** — Fair market prices for famous local products
- **Error Pages** — Custom 404 and 500 error pages
- **Responsive** — Works on mobile and desktop

---

## Pages & URLs

| URL | Servlet | JSP |
|---|---|---|
| `/TouristGuide/` | redirect | → `/home` |
| `/TouristGuide/home` | HomeServlet | index.jsp |
| `/TouristGuide/home?search=goa` | HomeServlet | index.jsp |
| `/TouristGuide/city?id=1` | CityServlet | city.jsp |
| `/TouristGuide/city?id=1&sort=fee` | CityServlet | city.jsp |
