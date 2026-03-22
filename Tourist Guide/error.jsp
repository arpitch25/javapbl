<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Error — Tourist Guide</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<nav class="navbar">
  <a href="${pageContext.request.contextPath}/home" class="navbar-brand">
    <span>🗺️</span> India Tourist Guide
  </a>
</nav>
<div class="container">
  <div class="empty-state" style="padding-top: 6rem;">
    <div style="font-size: 4rem; margin-bottom: 1rem;">😕</div>
    <h3>Something went wrong</h3>
    <p style="margin: 8px 0 24px;">
      <%= request.getAttribute("javax.servlet.error.message") != null
          ? request.getAttribute("javax.servlet.error.message")
          : "An unexpected error occurred." %>
    </p>
    <a href="${pageContext.request.contextPath}/home"
       style="background: var(--primary); color: #fff; padding: 10px 24px;
              border-radius: 8px; font-size: 0.9rem;">
      ← Back to Home
    </a>
  </div>
</div>
</body>
</html>
