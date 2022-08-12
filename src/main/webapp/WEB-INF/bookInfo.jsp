<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book Edit</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<body>
<div class="position-relative home-header">
    <h1>Welcome, <c:out value="${user.username}"/></h1>
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Logout" class="btn btn-primary" />
    </form>
</div>
<hr>
<body>
<div class="container-flex justify-content-between">
    <div class="sub-form">
        <h2 class="make-blue">"<i><c:out value="${book.title}"/> "</i></h2>
        <br>
        <h4>Added by <span class="make-blue"><c:out value="${book.creator.username}"/></span></h4>
        <br>
        <h5>Added on <c:out value="${book.getCreatedAtFormated()}"/></h5>
        <br>
        <h5>Last Update on <c:out value="${book.getUpdatedAtFormated()}"/></h5>
        <br>
        <h5>Description : <c:out value="${book.description}"/></h5>
    </div>
    <div class="sub-form">
        <h2 class="make-purple">Users who liked this book :</h2>
        <br>
        <ul>
            <c:forEach var="userLiked" items="${allLikers}">
                <li>
                    <h4><c:out value="${userLiked.username}"/>
                        <c:if test="${user == userLiked}">
                            <a href="/removeFavorites/${book.id}">Un-favorite</a>
                        </c:if>
                    </h4>
                </li>
                <br>
            </c:forEach>
        </ul>
        <c:if test="${!user.favoriteBooks.contains(book)}">
            <a href="/addToFavorites/${book.id}">Add to favorites</a>
        </c:if>
    </div>
</body>