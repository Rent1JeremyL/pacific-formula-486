<%@page import="com.rent1.factory.CategoryFactory"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.rent1.entity.User"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.rent1.reference.Category"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<script src="/webincludes/js/bootstrap-hover-dropdown.js"></script>
	<header class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<%
				CategoryFactory cf = CategoryFactory.getInstance();
				ArrayList<Category> catagories = cf.getPrimaryCatagories();
				User user = null;
				user = User.getUserSession(request);
				if (user != null) {
			%>
			<ul class="nav pull-right logout">
				<li><a href="/logout"><i class="icon icon-signout"></i> Log
						Out</a></li>
			</ul>
			<%
				}
			%>
			<div class="container">
				<a href="/" class="logo"><img src="/webincludes/img/logo.png"></a>
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class="dropdown"><a data-hover="dropdown"
							class="dropdown-toggle" href="#">BROWSE <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<%
									for ( Category cata : catagories){
								%>
								<li><a href="template.jsp"><%=cata%></a></li>
								<%
									}
								%>
							</ul></li>
					</ul>
				</div>
				<%
					if (user == null) {
				%>
				<a href="/register" class="btn btn-primary pull-right"
					style="margin: 1em">Create Account</a>
				<%
					}else if(user != null && user.getCompanyKey() == null){
				%><a href="/company/check" class="btn btn-brown pull-right"
					style="margin: 1em">LIST YOUR COMPANY</a>
				<%
					}
				%>
				<div class="nav-collapse collapse pull-right">
					<ul class="nav">
						<%
							if (user != null) {
						%>
						<li class="dropdown"><a data-hover="dropdown"
							class="dropdown-toggle"> WELCOME <%=user.getNickName()%>!, 
							<b class="caret"></b>
						</a>
							<ul class="dropdown-menu">
<%if(user.getCompanyKey() != null) { %><li><a href="/company">Company</a></li><%} %>
								<li><a href="/">Home</a></li>
								<li><a href="#">Orders</a></li>
								<li><a href="/profile">Profile</a></li>
							</ul>
						</li>
					<ul class="nav pull-right">
							<li><a href="/view-cart"><i class="icon icon-shopping-cart">
							</i> <%=user.getShoppingCart().getTotal() %></a></li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="/notices"><i class="icon icon-envelope">
							</i> <%=user.getMessageCount() %></a></li>
					</ul>
						<%
							} else {
						%>
						<li>
							<!-- href="userService.createLoginURL(request.getRequestURI())" -->
							<a href="/login">SIGN IN</a>
						</li>
						<%
							}
						%>
						<li class="dropdown"><a data-hover="dropdown"
							class="dropdown-toggle" href="#">HELP <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a href="#">Frequently Asked Questions</a></li>
								<li><a href="#">Support</a></li>
							</ul></li>
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</header>