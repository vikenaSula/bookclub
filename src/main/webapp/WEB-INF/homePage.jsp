<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome Page</title>
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
    <br>
    <hr>
    <div class="container-flex">
        <div class="sub-form">
            <h2 class="make-purple">Add a new book</h2>
        <form:form action="../books" method="post" modelAttribute="book">
            <div class="row mb-3 form-row">
                <form:label path="title" class="col-sm-3 col-form-label">Title: </form:label>
                <div class="col-sm-9">
                    <form:input path="title" class="form-control"/>
                    <form:errors path="title" class="text-danger"/>
                </div>
            </div>
            <div class="row mb-3 form-row">
                <form:label path="description" class="col-sm-3 col-form-label">Description : </form:label>
                <div class="col-sm-9">
                    <form:textarea rows="5" path="description" class="form-control"/>
                    <form:errors path="description" class="text-danger"/>
                </div>
            </div>
            <br>
            <input type="submit" value="Add" class="btn btn-primary" width="400px">
        </form:form>
    </div>
    <div class="sub-form">
        <h2 class="make-purple">All Books</h2>

        <c:forEach var="book" items="${allBooks}">
           <div>
               <br>
               <a href="../books/${book.id}"><c:out value="${book.title}"/></a>
               <br>
               (added by <span class="make-blue">
                  <c:if test="${user.id == book.creator.id}">
                      you
                  </c:if>
                  <c:if test="${user.id != book.creator.id}">
                     <c:out value="${book.creator.username}"/>
                  </c:if>
                </span>)<br>
               <c:if test="${user.favoriteBooks.contains(book)}">
                <i>this is one of your favorites</i>
               </c:if>
               <c:if test="${!user.favoriteBooks.contains(book)}">
                   <a href="/addToFavorites/${book.id}">Add to favorites</a>
               </c:if>
                <br>
                <br>
           </div>
        </c:forEach>

    </div>
    </div>
</body>
</html>