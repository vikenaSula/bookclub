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
        <div class="sub-content">
            <form:form action="../books/edit/${book.id}" method="post" modelAttribute="book">
                <input type="hidden" name="_method" value="put" >
                <div class="col-sm-10">
                    <form:input path="title"  class="form-control title-input"/>
                    <form:errors path="title" class="text-danger"/>
                </div>
                <br>
                <div>
                    <h5>Added by <c:out value="${book.creator.username}"/></h5>
                </div>
                <div>
                    <h5>Added on <c:out value="${book.getCreatedAtFormated()}"/></h5>
                </div>
                <div>
                    <h5>Last Update on <c:out value="${book.getUpdatedAtFormated()}"/></h5>
                </div>
                <div class="row mb-4 form-row">
                    <form:label path="description" class="col-sm-3 col-form-label">Description : </form:label>
                    <div class="col-sm-8">
                        <form:textarea path="description"  class="form-control"/>
                        <form:errors path="description" class="text-danger"/>
                    </div>
                </div>
                <input type="submit" value="Update" class="btn btn-primary">
            </form:form>
            <br>
            <a href="../books/delete/${book.id}">
                <button class="btn btn-danger">Delete</button>
            </a>
        </div>
        <div class="sub-form">
            <h3 class="make-purple">Users who liked this book :</h3>
            <ul>
                <c:forEach var="userLiked" items="${allLikers}">
                    <li><h4><c:out value="${userLiked.username}"/>
                            <c:if test="${user == userLiked}">
                                 <a href="/removeFavorites/${book.id}">Un-favorite</a>
                            </c:if>
                         </h4>
                        <br>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</body>