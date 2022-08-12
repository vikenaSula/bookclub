<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login and Registration Page</title>
</head>
<body>
    <div>
        <br>
        <h1 class="position-absolute top-20 start-50 translate-middle make-blue">Books Platform</h1>
        <br>
        <br>
    </div>
    <div class="container-flex">
        <div class="sub-form">
            <h2 class="form-header">Register</h2>
            <form:form action="/register" method="post" modelAttribute="user">
                <div class="row mb-3 form-row">
                    <label class="col-sm-3 col-form-label">Name:</label>
                    <div class="col-sm-9">
                        <form:errors path="username" class="text-danger"/>
                        <form:input path="username" class="form-control" required="true"/>
                    </div>
                </div>
                <div class="row mb-3 form-row">
                    <label class="col-sm-3 col-form-label">Email :</label>
                    <div class="col-sm-9">
                        <form:errors path="email" class="text-danger"/>
                        <form:input path="email" class="form-control" required="true" />
                    </div>
                </div>
                <div class="row mb-3 form-row">
                    <label class="col-sm-3 col-form-label">Password:</label>
                    <div class="col-sm-9">
                        <form:errors path="password" class="text-danger"/>
                        <form:password path="password" class="form-control" required="true"/>
                    </div>
                </div>
                <div class="row mb-3 form-row">
                    <label class="col-sm-3 col-form-label">Confirm PW:</label>
                    <div class="col-sm-9">
                        <form:errors path="passwordConfirmation" class="text-danger"/>
                        <form:password path="passwordConfirmation" class="form-control" required="true"/>
                    </div>
                </div>
            <input class="btn btn-primary form-row" type="submit" value="Submit"/>
            </form:form>
        </div>
        <div class="sub-form">
            <c:if test="${logoutMessage != null}">
                <p class="text-success"><c:out value="${logoutMessage}"></c:out></p>
            </c:if>
            <h2 class="form-header">Log in</h2>
            <c:if test="${errorMessage != null}">
                <p class="text-danger"><c:out value="${errorMessage}"></c:out></p>
            </c:if>
            <form method="post" action="/login">
                <div class="row mb-3 form-row">
                    <label class="col-sm-3 col-form-label">Email: </label>
                    <div class="col-sm-9">
                        <input type="text" id="email" name="email" class="form-control" required="true"/>
                    </div>
                </div>
                <div class="row mb-3 form-row">
                    <label class="col-sm-3 col-form-label">Password: </label>
                    <div class="col-sm-9">
                        <input type="password" id="password" name="password" class="form-control" required="true"/>
                    </div>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="submit" value="Login!" class="btn btn-primary form-row"/>
            </form>
        </div>
    </div>
</body>
</html>
