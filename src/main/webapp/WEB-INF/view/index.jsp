<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Basic Dictionary</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
  <c:set var="contextPath" value="${pageContext.request.contextPath}" />
  <c:set var="role" value="${sessionScope.role}" />
  <c:set var="isAdmin" value="${ not empty role && role=='ADM' }" />

  <div class="container">
    <h3>${ role }</h3>
    <form class="form-inline" action="${ contextPath }/search">
      <!-- Start of drop down -->
      <div class="form-group">
        <label for="sel-trans-type">Select translation type:</label> <select
          class="form-control" id="sel-trans-type" name="trans-type">
          <c:forEach items="${ transTypes }" var="transType">
            <c:choose>
              <c:when test="${ transType.type == curTransType }">
                <option value="${ transType.type }" selected="selected">${ transType.typeValue }</option>
              </c:when>
              <c:otherwise>
                <option value="${ transType.type }">${ transType.typeValue }</option>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </select>
      </div>
      <!-- End of drop down -->
      
      <!-- Start of search box -->
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search"
          name="search-word" value="${ searchWord }">
        <div class="input-group-append">
          <button class="btn btn-success" type="submit">Go</button>
        </div>
      </div>
      <!-- End of search box -->
    </form>

    <a href="${ contextPath }/logout"><button type="button"
        class="btn btn-link">Sign out</button></a>
    <hr>

    <c:if test="${ not empty words }">
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>Word</th>
            <th>Meanings</th>
            <c:if test="${ isAdmin }">
              <th>Operations</th>
            </c:if>
          </tr>
        </thead>
        <tbody>
          <c:forEach items="${ words }" var="word">
            <tr>
              <td>${ word.key }</td>
              <td>${ word.meanings }</td>
              <c:if test="${ isAdmin }">
                <c:url value="/edit" var="detailUrl">
                  <c:param name="word-id" value="${ word.id }"></c:param>
                </c:url>
                <c:url value="/delete" var="deleteUrl">
                  <c:param name="word-id" value="${ word.id }"></c:param>
                </c:url>
                <td>
                  <a href="${ detailUrl }"><button
                      type="button" class="btn btn-link">Edit</button></a>
                  <a href="${ deleteUrl }"><button
                      type="button" class="btn btn-link">Delete</button></a>
                </td>
              </c:if>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>

</body>
</html>