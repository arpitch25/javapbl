<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${place.name} — India Tourist Guide</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/place.css">
</head>
<body>

<!-- ===== Navbar ===== -->
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/home" class="navbar-brand">
    <span>🗺️</span> India Tourist Guide
  </a>
  <form action="${pageContext.request.contextPath}/home" method="get" class="navbar-search">
    <input type="text" name="search" placeholder="Search cities...">
    <button type="submit">🔍</button>
  </form>
  <a href="${pageContext.request.contextPath}/home" class="navbar-home">🏠 Home</a>
</nav>

<!-- ===== Breadcrumb ===== -->
<div class="breadcrumb-bar">
  <div class="container">
    <a href="${pageContext.request.contextPath}/home">Home</a>
    &nbsp;›&nbsp;
    <a href="${pageContext.request.contextPath}/city?id=${city.id}">${city.name}</a>
    &nbsp;›&nbsp;
    <span>${place.name}</span>
  </div>
</div>

<!-- ===== Main ===== -->
<main class="container" style="padding-top: 1.5rem; padding-bottom: 3rem;">

  <!-- Back button -->
  <a href="${pageContext.request.contextPath}/city?id=${city.id}" class="back-btn">
    ← Back to ${city.name}
  </a>

  <!-- ===== Hero Banner ===== -->
  <div class="place-hero" style="background: ${place.bgColor};">
    <div class="place-hero-emoji">${place.emoji}</div>
    <div class="place-hero-overlay"></div>
  </div>

  <!-- ===== Info Bar ===== -->
  <div class="info-bar">
    <div class="info-chip">🕐 <strong>${place.timings}</strong></div>
    <div class="info-chip">
      🎫 Entry:&nbsp;
      <strong>
        <c:choose>
          <c:when test="${place.entryFee == 0}">Free</c:when>
          <c:otherwise>₹<fmt:formatNumber value="${place.entryFee}" maxFractionDigits="0"/></c:otherwise>
        </c:choose>
      </strong>
    </div>
    <div class="info-chip">⭐ <strong>${place.rating}</strong></div>
    <div class="info-chip">⏱️ <strong>${place.duration}</strong></div>
  </div>

  <!-- ===== Title + Description ===== -->
  <div class="place-title-block">
    <h1>${place.name}</h1>
    <span class="badge ${city.badgeClass}">${city.theme}</span>
    <p class="place-full-desc">${place.description}</p>
  </div>

  <!-- ===== Two Column Layout ===== -->
  <div class="place-grid">

    <!-- LEFT COLUMN -->
    <div class="place-main">

      <!-- Photos -->
      <div class="section-card">
        <div class="section-heading">📸 Photos</div>
        <div class="photo-grid">
          <c:forEach var="photo" items="${place.photos}">
            <div class="photo-cell" style="background: ${place.bgColor};">
              <span class="photo-emoji">${photo}</span>
            </div>
          </c:forEach>
        </div>
      </div>

      <!-- Activities -->
      <div class="section-card">
        <div class="section-heading">🎯 Activities</div>
        <div class="activity-grid">
          <c:forEach var="act" items="${place.activities}">
            <div class="activity-card">
              <div class="activity-icon">${act.icon}</div>
              <div class="activity-body">
                <div class="activity-name">${act.name}</div>
                <div class="activity-desc">${act.description}</div>
              </div>
            </div>
          </c:forEach>
        </div>
      </div>

    </div>

    <!-- RIGHT COLUMN -->
    <div class="place-side">

      <!-- Popular Things -->
      <div class="section-card">
        <div class="section-heading">⭐ Popular things here</div>
        <ul class="popular-list">
          <c:forEach var="thing" items="${place.popularThings}">
            <li class="popular-item">
              <span class="popular-dot"></span>
              <span>${thing}</span>
            </li>
          </c:forEach>
        </ul>
      </div>

      <!-- Quick Info card -->
      <div class="section-card quick-info">
        <div class="section-heading">ℹ️ Quick Info</div>
        <table class="info-table">
          <tr>
            <td class="info-label">City</td>
            <td class="info-value">
              <a href="${pageContext.request.contextPath}/city?id=${city.id}">${city.name}</a>
            </td>
          </tr>
          <tr>
            <td class="info-label">Theme</td>
            <td class="info-value">${city.theme}</td>
          </tr>
          <tr>
            <td class="info-label">Timings</td>
            <td class="info-value">${place.timings}</td>
          </tr>
          <tr>
            <td class="info-label">Entry</td>
            <td class="info-value">
              <c:choose>
                <c:when test="${place.entryFee == 0}">
                  <span style="color:#27500a; font-weight:500;">Free</span>
                </c:when>
                <c:otherwise>
                  ₹<fmt:formatNumber value="${place.entryFee}" maxFractionDigits="0"/>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
          <tr>
            <td class="info-label">Rating</td>
            <td class="info-value">⭐ ${place.rating} / 5</td>
          </tr>
          <tr>
            <td class="info-label">Duration</td>
            <td class="info-value">${place.duration}</td>
          </tr>
        </table>
      </div>

      <!-- Traveller tip -->
      <div class="tip-card">
        <div style="font-size: 1.2rem; margin-bottom: 6px;">💡</div>
        <div style="font-size: 0.85rem; color: #124d41; line-height: 1.6;">
          Check the <a href="${pageContext.request.contextPath}/city?id=${city.id}&tab=prices" style="color:#1a6b5a;font-weight:500;">Fair Prices tab</a>
          in ${city.name} before shopping nearby to avoid tourist overcharging.
        </div>
      </div>

    </div>
  </div>
</main>

<!-- ===== Footer ===== -->
<footer class="footer">
  <p>India Tourist Guide &nbsp;|&nbsp; Java Servlets + JSP + JDBC + MySQL &nbsp;|&nbsp; Academic Project</p>
</footer>

</body>
</html>
