<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${city.name} — India Tourist Guide</title>
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
<div style="background: #fff; border-bottom: 1px solid var(--border); padding: 10px 0;">
  <div class="container" style="font-size:0.85rem; color: var(--text-s);">
    <a href="${pageContext.request.contextPath}/home" style="color: var(--primary);">Home</a>
    &nbsp;›&nbsp; ${city.name}
  </div>
</div>

<!-- ===== Main Layout ===== -->
<main class="container">
  <div class="detail-layout">

    <!-- ===== Sidebar ===== -->
    <aside class="sidebar">
      <div class="sidebar-box">
        <div class="sidebar-heading">All Cities</div>
        <c:forEach var="c" items="${allCities}">
          <a href="${pageContext.request.contextPath}/city?id=${c.id}"
             class="sidebar-city-link ${c.id == city.id ? 'active' : ''}">
            <c:choose>
              <c:when test="${c.badgeClass == 'badge-heritage'}">🏰</c:when>
              <c:when test="${c.badgeClass == 'badge-beach'}">🏖️</c:when>
              <c:when test="${c.badgeClass == 'badge-adventure'}">⛰️</c:when>
              <c:when test="${c.badgeClass == 'badge-spiritual'}">🕌</c:when>
              <c:otherwise>📍</c:otherwise>
            </c:choose>
            ${c.name}
          </a>
        </c:forEach>
      </div>

      <!-- Price tip box -->
      <div class="sidebar-box">
        <div class="sidebar-heading">Traveller Tip</div>
        <div style="padding: 14px 16px; font-size: 0.85rem; color: var(--text-m); line-height: 1.6;">
          Always check the <strong>Fair Prices</strong> tab before shopping to avoid being overcharged.
        </div>
      </div>
    </aside>

    <!-- ===== Main Content ===== -->
    <section>

      <!-- City Hero -->
      <div class="city-hero">
        <div class="city-hero-banner">
          <c:choose>
            <c:when test="${city.badgeClass == 'badge-heritage'}">🏰</c:when>
            <c:when test="${city.badgeClass == 'badge-beach'}">🏖️</c:when>
            <c:when test="${city.badgeClass == 'badge-adventure'}">⛰️</c:when>
            <c:when test="${city.badgeClass == 'badge-spiritual'}">🕌</c:when>
            <c:otherwise>🌆</c:otherwise>
          </c:choose>
        </div>
        <div class="city-hero-body">
          <h1>${city.name}</h1>
          <div class="subtitle">
            <span class="badge ${city.badgeClass}">${city.theme}</span>
          </div>
          <c:if test="${not empty city.highlight}">
            <div class="city-highlight">💡 ${city.highlight}</div>
          </c:if>
        </div>
      </div>

      <!-- ===== Tabs ===== -->
      <div class="tab-bar">
        <button class="tab-btn active" onclick="switchTab('history', this)">📜 History</button>
        <button class="tab-btn"       onclick="switchTab('places',  this)">📍 Places</button>
        <button class="tab-btn"       onclick="switchTab('prices',  this)">🛒 Fair Prices</button>
      </div>

      <!-- HISTORY TAB -->
      <div id="tab-history" class="tab-panel active">
        <div class="history-text">
          ${city.history}
        </div>
      </div>

      <!-- PLACES TAB -->
      <div id="tab-places" class="tab-panel">
        <!-- Sort bar -->
        <div class="sort-bar">
          <span>Sort by:</span>
          <a href="${pageContext.request.contextPath}/city?id=${city.id}&sort=name">
            <button class="sort-btn ${sortMode == 'name' ? 'active' : ''}">Name</button>
          </a>
          <a href="${pageContext.request.contextPath}/city?id=${city.id}&sort=fee">
            <button class="sort-btn ${sortMode == 'fee' ? 'active' : ''}">Entry Fee</button>
          </a>
        </div>

        <c:choose>
          <c:when test="${empty places}">
            <div class="empty-state">
              <h3>No places listed yet.</h3>
            </div>
          </c:when>
          <c:otherwise>
            <c:forEach var="place" items="${places}">
              <a href="${pageContext.request.contextPath}/place?id=${place.id}" class="place-card-link">
                <div class="place-card">
                  <div style="display:flex; align-items:flex-start; gap:14px;">
                    <div style="font-size:2rem; flex-shrink:0;">📍</div>
                    <div style="flex:1;">
                      <div class="place-name">${place.name}</div>
                      <div class="place-desc">${place.description}</div>
                      <div class="place-meta">
                        <span class="meta-pill">🕐 ${place.timings}</span>
                        <c:choose>
                          <c:when test="${place.entryFee == 0}">
                            <span class="meta-pill free">✅ Free Entry</span>
                          </c:when>
                          <c:otherwise>
                            <span class="meta-pill paid">🎫 Entry: ${place.formattedFee}</span>
                          </c:otherwise>
                        </c:choose>
                      </div>
                      <div class="view-detail-btn">View Photos, Activities & More →</div>
                    </div>
                  </div>
                </div>
              </a>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- FAIR PRICES TAB -->
      <div id="tab-prices" class="tab-panel">
        <div class="price-warning">
          <span style="font-size: 1.2rem;">⚠️</span>
          <span>These are <strong>fair market prices</strong>. If a seller quotes more, politely negotiate or walk away.</span>
        </div>

        <c:choose>
          <c:when test="${empty products}">
            <div class="empty-state">
              <h3>No price data available yet.</h3>
            </div>
          </c:when>
          <c:otherwise>
            <div class="price-table">
              <c:forEach var="product" items="${products}">
                <div class="price-row">
                  <div>
                    <div class="price-item-name">${product.productName}</div>
                    <div class="price-item-note">${product.notes}</div>
                  </div>
                  <div class="price-value-col">
                    <div class="price-value">
                      ₹<fmt:formatNumber value="${product.fairPrice}" maxFractionDigits="0"/>
                    </div>
                    <div class="price-unit">${product.unit}</div>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </section>
  </div>
</main>

<!-- ===== Footer ===== -->
<footer class="footer">
  <p>India Tourist Guide &nbsp;|&nbsp; Java Servlets + JSP + JDBC + MySQL &nbsp;|&nbsp; Academic Project</p>
</footer>

<!-- ===== Tab JS ===== -->
<script>
  function switchTab(name, btn) {
    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById('tab-' + name).classList.add('active');
    btn.classList.add('active');
  }

  // Open correct tab if sort was applied (means user was on places tab)
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get('sort')) {
    document.querySelectorAll('.tab-btn')[1].click();
  }
</script>

</body>
</html>
