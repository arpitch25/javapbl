<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>India Tourist Guide</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- ===== Navbar ===== -->
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/home" class="navbar-brand">
    <span>🗺️</span> India Tourist Guide
  </a>

  <form action="${pageContext.request.contextPath}/home" method="get" class="navbar-search">
    <input type="text" name="search"
           placeholder="Search cities..."
           value="${searchQuery != null ? searchQuery : ''}">
    <button type="submit">🔍</button>
  </form>

  <a href="${pageContext.request.contextPath}/home" class="navbar-home">🏠 Home</a>
</nav>

<!-- ===== Hero ===== -->
<section class="hero">
  <h1>Explore India</h1>
  <p>Discover cities, iconic places, and know fair prices before you shop.</p>
</section>

<!-- ===== City Grid ===== -->
<main class="container">

  <c:if test="${searchQuery != null}">
    <p style="padding: 1.5rem 0 0; color: #4a4a4c; font-size: 0.9rem;">
      Showing results for "<strong>${searchQuery}</strong>"
      — <a href="${pageContext.request.contextPath}/home" style="color: var(--primary)">clear</a>
    </p>
  </c:if>

  <c:choose>
    <c:when test="${empty cities}">
      <div class="empty-state" style="padding-top: 4rem;">
        <div style="font-size: 3rem; margin-bottom: 1rem;">🔍</div>
        <h3>No cities found</h3>
        <p>Try a different search term.</p>
      </div>
    </c:when>
    <c:otherwise>
      <div class="city-grid">
        <c:forEach var="city" items="${cities}">
          <a href="${pageContext.request.contextPath}/city?id=${city.id}" class="city-card">
            <div class="city-card-img">
              <c:choose>
                <c:when test="${city.badgeClass == 'badge-heritage'}">🏰</c:when>
                <c:when test="${city.badgeClass == 'badge-beach'}">🏖️</c:when>
                <c:when test="${city.badgeClass == 'badge-adventure'}">⛰️</c:when>
                <c:when test="${city.badgeClass == 'badge-spiritual'}">🕌</c:when>
                <c:when test="${city.badgeClass == 'badge-food'}">🍜</c:when>
                <c:otherwise>📍</c:otherwise>
              </c:choose>
            </div>
            <div class="city-card-body">
              <div class="city-card-name">${city.name}</div>
              <div class="city-card-theme">${city.theme}</div>
              <span class="badge ${city.badgeClass}">${city.theme}</span>
              <div class="city-card-arrow">
                <span>Explore</span>
                <span>→</span>
              </div>
            </div>
          </a>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

</main>

<!-- ===== Footer ===== -->
<footer class="footer">
  <p>India Tourist Guide &nbsp;|&nbsp; Java Servlets + JSP + JDBC + MySQL &nbsp;|&nbsp; Academic Project</p>
</footer>

</body>
</html>
