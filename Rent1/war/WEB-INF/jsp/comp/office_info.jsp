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
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<%
		// Protected JSP - Leave now
		if (user == null) {
			request.getRequestDispatcher("denied.html").forward(request,
					response);
			return;
		}
		Company comp = user.getCompany();
	%>
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
					int linkID = 0;
				%>
				<ul class="tabs" data-persist="true">
					<li><a href="/company">Company Information</a></li>
					<li><span class="tab_select">Office Information</span></li>
					<%
						if (offices.size() != 0) {
					%>
					<li><a href="/company/equipment">Equipment</a></li>
					<li><a href="/company/equipment/add">Add Equipment</a></li>
					<%
						}
					%>
				</ul>
				<div class="control-group tabcontents">
					<div id="cTab2">
						<div class="row" style="padding: 6px; margin-left: 20px">
							<div class="boxed-group span11">
								<h3>Offices</h3>
								<div class="boxed-group-inner">
									<ul class="boxed-group-list standalone">
										<%
											linkID = 0;
											int officeCount = offices.size();
											if (offices != null) {
												for (Office office : offices) {
													linkID++;
													// there is a delay in delete, result may have null
													if (office != null) {
										%>
										<li class="clearfix"><strong><%=office.toString()%></strong>
											<a id="offdelete-<%=linkID %>" class="btn btn-small minibutton"
											onClick="return deletechecked('Deleting this office will also delete its equipment.  Are you sure?')"
											href="/delete/office?officeId=<%=office.getId()%>">Delete</a> 
											<a class="btn btn-small minibutton"
											onclick="showDetailsGroup('officedetails','details-','<%=linkID%>','<%=officeCount%>')">View</a></li>
										<%
											}
												}
											}
										%>
									</ul>
								</div>
							</div>
							<div>
								<a id="createOffice" class="btn"
									style="margin: 10px 0px 3px 0px;" href="/company/add/office">Create
									new office</a>
							</div>
							<div id="officedetails" class="boxed-group span11"
								style="display: none;">
								<h3>Office Details</h3>
								<div class="boxed-group-inner">
									<ul class="boxed-group-list standalone">
										<%
											linkID = 0;
											if (offices != null) {
												for (Office office : offices) {
													// there is a delay in delete, result may have null
													if (office != null) {
														linkID++;
										%>
										<li id="details-<%=linkID%>" class="clearfix"
											style="display: none;">
											<div>
												<p class="placeholder-label label_input_left">*Street 1:</p>
												<input id="add-street1-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-street1-<%=linkID%>"
													value="<%=office.getAddress().getStreet1() %>" disabled="disabled"
													type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">Street 2:</p>
												<input id="add-street2-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-street2-<%=linkID%>"
													value="<%=office.getAddress().getStreet2() %>" disabled="disabled"
													type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">*City:</p>
												<input id="add-city-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-city-<%=linkID%>"
													value="<%=office.getAddress().getCity() %>" disabled="disabled"
													type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">*Post Code:</p>
												<input id="add-zip-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-zip-<%=linkID%>"
													value="<%=office.getAddress().getPostCode() %>" disabled="disabled"
													type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">*State/Province:</p>
												<input id="add-state-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-state-<%=linkID%>"
													value="<%=office.getAddress().getState() %>" disabled="disabled"
													type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">*Country:</p>
												<input id="add-country-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-country-<%=linkID%>"
													value="<%=office.getAddress().getCountry() %>" disabled="disabled"
													type="text" style="width: 210px;"
													required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">Phone:</p>
												<input id="add-phone-<%=linkID%>"
													class="placeholder-label data_input_right"
													name="add-phone-<%=linkID%>"
													value="<%=office.getPhone() %>" disabled="disabled"
													type="tel" style="width: 210px;"
													placeholder="000-000-0000" required>
											</div>
											<div>
												<p class="placeholder-label label_input_left">Fax:</p>
												<input id="add-fax-<%=linkID%>"
													class="placeholder-label data_input_right"
													name=""add-fax-<%=linkID%>""
													value="<%=office.getFax() %>" disabled="disabled"
													type="tel" style="width: 210px;"
													placeholder="000-000-0000" required>
											</div>
										</li>
										<%
											}
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
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>