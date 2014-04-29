<%@page import="com.rent1.entity.DefaultProduct"%>
<%@page import="com.rent1.dao.OfficeDao"%>
<%@page import="com.rent1.entity.Company"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="com.rent1.entity.Office"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Company Profile</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<!-- START Tab Content -->
<link rel="stylesheet" href="/webincludes/css/tabcontent3.css">
<script src="/webincludes/js/tabcontent.js"></script>
<!-- END Tab Content -->
<link rel="icon" type="image/png" href="/favicon.ico">
<!-- ==== START [load bootstrap elements] ========== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ==== END ====================================== -->
<script src="/webincludes/js/rent1.js"></script>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="/webincludes/js/html5shiv.js"></script>
<![endif]-->
</head>
<body>
	<!-- ======== javascript create AutoComplete by Categories ======== -->
	<script>
document.getElementById('search-prod').value='<%=session.getAttribute("searchString")%>';

<%String secCatas = CategoryFactory.getInstance().getAllSecondayCatagoriesToJSArray();%>
$(function() {
	var availableTags = [<%=secCatas%>];
	$( "#search-prod" ).autocomplete({
		source: availableTags
	});
});
</script>
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<%
		// Protected JSP - Leave now
		if (user == null) {
			request.getRequestDispatcher("denied.html").forward(request,response);
			return;
		}
		Company comp = user.getCompany();
	%>
	<!-- javascript create Category variables =============== -->
	<script>
	var secArray = new Array();
	<%int i=1;
	for(Category cata : catagories){
		String secArray = CategoryFactory.getInstance().getSecondayCatagoriesToJS(cata);%>
		secArray[<%=i%>]="<%=secArray%>";
	<%i++;
	}%>
		
	</script>
	<div class="content" style="background: #D8D8D8;">
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div id="profile">
				<div class="section-title_h">
					<h3 class="title_green">
						<%=comp.getName()%>
					</h3>
				</div>
				<br>
				<%
					List<Office> offices = OfficeDao.INSTANCE.getOfficesByCompany(comp);
				%>
				<ul class="tabs" data-persist="true">
					<li><a href="#cTab1">Company Information</a></li>
					<li><a href="#cTab2">Office Information</a></li>
					<%
						if (offices.size() != 0) {
					%>
					<li><a href="#cTab3">Equipment</a></li>
					<li><a href="#cTab4">Add Equipment</a></li>
					<%
						}
					%>
				</ul>
				<div class="control-group tabcontents">
					<div id="cTab1">
						<form action="/#" method="post">
							<dl>
								<dt class="prof_h1_left">Email Address:</dt>
								<dd class="prof_input_right">
									<input id="profcomp-email" name="profcomp-email"
										class="input-large placeholder-input has-text" type="text"
										value="<%=comp.getEmail()%>" required>
								</dd>
							</dl>
							<dl>
								<dt class="prof_h1_left">Phone Number:</dt>
								<dd class="prof_input_right">
									<input id="profcomp-phone" name="profcomp-phone"
										class="input-large" type="tel"
										value="<%=comp.getPhoneNumber()%>" required>
								</dd>
							</dl>
							<dl>
								<dt class="prof_h1_left">Fax Number:</dt>
								<dd class="prof_input_right">
									<input id="profcomp-fax" name="profcomp-fax"
										class="input-large placeholder-input has-text" type="tel"
										value="<%=comp.getFaxNumber()%>"></input>
								</dd>
							</dl>
						</form>
					</div>
					<div id="cTab2">
						<div class="row" style="padding: 6px; margin-left: 20px">
							<div>
								<a id="createOffice" class="btn"
									style="margin: 10px 0px 3px 0px;" href="/company/add/office">Create
									new office</a>
							</div>
							<div class="boxed-group span11">
								<h3>Offices</h3>
								<div class="boxed-group-inner">
									<ul class="boxed-group-list standalone">
										<%
											if (offices != null) {
												for (Office office : offices) {
										%>
										<li class="clearfix"><strong><%=office.toString()%></strong>
											<a class="btn btn-small minibutton"
											href="/delete/office/<%=office.getId()%>">Delete</a></li>
										<%
											}
											}
										%>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<%
						if (offices.size() != 0) {
					%>
					<div id="cTab3">
						<div class="row">
							<div class="span12">
								<aside class="span3">
									<section class="boxed-menu">
										<h3>Offices</h3>
										<div class="boxed-menu-inner">
											<ul class="boxed-group-list standalone">
												<%
													int linkID = 0;
														if (offices != null) {
															for (Office office : offices) {
																linkID++;
												%>
												<li><a href="#office-<%=linkID%>">Office <%=linkID%></a><br>
													&bull; <%=office.toShortString()%></li>
												<%
													}
														}
												%>
											</ul>
										</div>
									</section>
								</aside>
								<div class="span8">
									<div class="boxed-group span8">
										<h3>Equipment</h3>
										<div class="boxed-group-inner">
											<ul class="boxed-group-list standalone">
												<%
													linkID = 0;
														if (offices != null) {
															for (Office office : offices) {
																linkID++;
												%>
												<li><a id="office-<%=linkID%>" class="more"
													data-toggle="collapse" data-target="#table-<%=linkID%>">
														<b>Office <%=linkID + ", " + office.toString()%> (7)
													</b>
												</a>
													<div class="collapse" id="table-<%=linkID%>">
														<table class="table small">
															<tr>
																<td class="clearfix">John Deere <a
																	class="btn btn-small minibutton"
																	data-confirm="Are you POSITIVE you want to delete this item?"
																	href="/delete/equipment?id=">Delete</a><a
																	class="btn btn-small minibutton"
																	href="/edit/equipment?id=">Edit</a>
																</td>
															</tr>
															<tr>
																<td class="clearfix">John Deere2 <a
																	class="btn btn-small minibutton"
																	data-confirm="Are you POSITIVE you want to delete this item?"
																	href="/delete/equipment?id=">Delete</a>
																</td>
															</tr>
														</table>
													</div></li>
												<%
													}
														}
												%>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="cTab4" class="container row">
						<div class="span11 search-horizontal">
							<h5 class="strong">Add rental equipment</h5>
							<form class="form-horizontal find-equipment gray-box"
								action="/company/search/product" method="POST">
								<fieldset>
									<div class="rental-wrap wrap span8">
										<input id="search-prod" name="search-prod"
											placeholder="Search for equipment to add" type="text"
											required> <span class="icon-wrench"></span>
									</div>
									<button id="submit" class="btn btn-primary" type="submit">
										<i class="icon icon-search"></i> Search
									</button>
								</fieldset>
							</form>
						</div>
						<div>
							<%
								List<DefaultProduct> prods = (ArrayList<DefaultProduct>) session
											.getAttribute("officeProds");
									if (prods != null) {
							%>
							<form id="frm-add-prod" action="/company/add/product"
								method="post">
								<div class="span10">
									<select id="add-office" name="add-office">
										<option value="0">Choose an Office</option>
										<%
											if (offices != null) {
														for (Office office : offices) {
										%>
										<option value="<%=office.getId()%>"><%=office.toShortString()%></option>
										<%
											}
													}
										%>
									</select>
								</div>
								<div class="span8">
									<div style="color: black;">${resultMessage}</div>
									<div style="color: red;">${errCompany}</div>
									<table class="det_table_spec">
										<tr>
											<th>Equipment</th>
											<th>Quantity</th>
											<th>Hourly</th>
											<th>Daily</th>
											<th>Weekly</th>
											<th>Monthly</th>
											<th></th>
										</tr>
										<%
											for (DefaultProduct prod : prods) {
										%>
										<tr>
											<td><%=prod.getWebTitle()%><input
												name="add-prodid-<%=prod.getId()%>"
												id="add-prodid-<%=prod.getId()%>" value="<%=prod.getId()%>"
												type="hidden"></td>
											<td><input
												name="add-prodquant-<%=prod.getId()%>"
												id="add-prodquant-<%=prod.getId()%>" type="number" value="1"
												class="span1" pattern="[0-9]" required></td>
											<td><input
												name="add-prod-h-<%=prod.getId()%>"
												id="add-prod-h-<%=prod.getId()%>" type="number" value="0"
												class="span1" pattern="?[0-9]" required></td>
											<td><input
												name="add-prod-d-<%=prod.getId()%>"
												id="add-prod-d-<%=prod.getId()%>" type="number" value="0"
												class="span1" pattern="?[0-9]" required></td>
											<td><input
												name="add-prod-w-<%=prod.getId()%>"
												id="add-prod-w-<%=prod.getId()%>" type="number" value="0"
												class="span1" pattern="?[0-9]" required></td>
											<td><input
												name="add-prod-m-<%=prod.getId()%>"
												id="add-prod-m-<%=prod.getId()%>" type="number" value="0"
												class="span1" pattern="?[0-9]" required></td>
											<td><button id="submit-<%=prod.getId()%>"
													name="submit-<%=prod.getId()%>" class="btn" type="submit">Add
												</button></td>
										</tr>
										<%
											}
										%>
									</table>
								</div>
							</form>
							<%
								}
							%>
						</div>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>