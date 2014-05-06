<%@page import="com.rent1.entity.RentalProduct"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<meta charset="utf-8">
<title>RENT1 - Rental Request</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">
<link rel="icon" type="image/png" href="/favicon.ico">
<!-- ==== START [load bootstrap elements] ========== -->
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ==== END ====================================== -->
<!-- ==== START [Ajax Datepicker] -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- ==== END [Ajax Datepicker] -->
<script src="/webincludes/js/rent1.js"></script>
<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="/webincludes/js/html5shiv.js"></script>
<![endif]-->
</head>
<body>
	<script type='text/javascript'>
		$(function() {
			$("#rentstart").datepicker({ dateFormat: 'mm/dd/yy' });
			$("#rentstart").datepicker('setDate','<%=session.getAttribute("searchStart")%>');
			
			$("#rentend").datepicker({ dateFormat: 'mm/dd/yy' });
			$("#rentend").datepicker('setDate','<%=session.getAttribute("searchEnd")%>');
		});

		function copyAddress() {
			var street1 = document.getElementById('rent-strt1').value;
			var street2 = document.getElementById('rent-strt2').value;
			var city = document.getElementById('rent-city').value;
			var prov = document.getElementById('rent-prov').value;

			document.getElementById('rent-del-strt1').value = street1;
			document.getElementById('rent-del-strt2').value = street2;
			document.getElementById('rent-del-city').value = city;
			document.getElementById('rent-del-prov').value = prov;
		}
	</script>
	<%@include file='/WEB-INF/jsp/header.jsp'%>
	<div class="content" style="background: #D8D8D8;">
		<%
			RentalProduct prod = (RentalProduct) request
					.getAttribute("rentalProd");
		%>
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div>
				<div class="section-title_h">
					<h3 class="title_green">Rental - Request<img alt="" src="/webincludes/img/order_status1.png"></h3>
				</div>
				<br>
				<div class="row control-group">
					<form method="post" action="/rental/review">
						<div class="groove_border span11 pad5">
							<h3 class="pad5">Rental Period</h3>
							<div class="wrap span5">
								<p class="prof_h1_left">Start Date:</p>
								<input id="rentstart" name="rentstart"
									class="placeholder-input has-text" placeholder="Start Date"
									type="text" required>
							</div>
							<div class="wrap span5">
								<p class="prof_h1_left">End Date:</p>
								<input id="rentend" name="rentend"
									class="placeholder-input has-text" placeholder="End Date"
									type="text" required>
							</div>
						</div>
						<aside id="rentalbox" class="groove_border span5">
							<h3 class="pad5">Customer</h3>
							<div>
								<p class="prof_h1_left">Driver's Lic. #:</p>
								<input id="rent-dlnum" class="placeholder-input has-text"
									name="rent-dlnum" value="" type="number" required>
							</div>
							<div>
								<p class="prof_h1_left">Company Name:</p>
								<input id="rent-comp" class="placeholder-input has-text"
									name="rent-comp" value="" type="number">
							</div>
							<div>
								<p class="prof_h1_left">Full Name:</p>
								<input id="rent-fname" class="placeholder-input has-text"
									name="rent-fname"
									value="<%=user.getFirstName() + " " + user.getLastName()%>"
									type="number" required>
							</div>
							<div>
								<p class="prof_h1_left">Street 1:</p>
								<input id="rent-strt1" class="placeholder-input has-text"
									name="rent-strt1" value="<%=user.getAddress().getStreet1()%>" type="number"
									required>
							</div>
							<div>
								<p class="prof_h1_left">Street 2:</p>
								<input id="rent-strt2" class="placeholder-input has-text"
									name="rent-strt2" value="<%=user.getAddress().getStreet2()%>" type="number">
							</div>
							<div>
								<p class="prof_h1_left">City:</p>
								<input id="rent-city" class="placeholder-input has-text"
									name="rent-city" value="<%=user.getAddress().getCity()%>" type="number"
									required>
							</div>
							<div>
								<p class="prof_h1_left">State/Province:</p>
								<input id="rent-prov" class="placeholder-input has-text"
									name="rent-prov" value="<%=user.getAddress().getState()%>" type="number"
									required>
							</div>
						</aside>
						<div class="span6">
							<div id="rentalbox" class="groove_border">
								<h3 class="pad5">Equipment</h3>
								<div>
									<p class="prof_h1_left">Type:</p>
									<input id="rent-ptype" class="placeholder-input has-text"
										disabled="disabled" name="rent-ptype"
										value="<%=prod.getCategory()%>" type="number" required>
								</div>
								<div>
									<p class="prof_h1_left">Make:</p>
									<input id="rent-pmake" class="placeholder-input has-text"
										disabled="disabled" name="rent-pmake"
										value="<%=prod.getMake()%>" type="number" required>
								</div>
								<div>
									<p class="prof_h1_left">Model:</p>
									<input id="rent-pmodel" class="placeholder-input has-text"
										disabled="disabled" name="rent-pmodel"
										value="<%=prod.getModelName()%>" type="number" required>
									<input id="rent-prd-id" class="placeholder-input has-text"
										name="rent-prd-id" value="<%=prod.getId()%>" type="hidden">
								</div>
							</div>
							<div id="rentalbox" class="groove_border">
								<h3 class="pad5">Delivery</h3>
								<div>
									<div style="margin-left: 30px;">
										<input type="checkbox" id="confirm" name="confirm"
											onClick="copyAddress()" value="confirm"><i> Same
											as customer</i>
									</div>
									<div>
										<p class="prof_h1_left">Street 1:</p>
										<input id="rent-del-strt1" class="placeholder-input has-text"
											name="rent-del-strt1" value="" type="number" required>
									</div>
									<div>
										<p class="prof_h1_left">Street 2:</p>
										<input id="rent-del-strt2" class="placeholder-input has-text"
											name="rent-del-strt2" value="" type="number">
									</div>
									<div>
										<p class="prof_h1_left">City:</p>
										<input id="rent-del-city" class="placeholder-input has-text"
											name="rent-del-city" value="" type="number" required>
									</div>
									<div>
										<p class="prof_h1_left">State/Province:</p>
										<input id="rent-del-prov" class="placeholder-input has-text"
											name="rent-del-prov" value="" type="number" required>
									</div>
								</div>
							</div>
						</div>
						<div class="span11 groove_border pad10">
							<aside class="span5">
								<label class="attach_box_lbl">Extra Attachments:</label>
								<textarea class="attach_box" title="Attachments"
									name="additions" cols="25" rows="10"
									placeholder="Enter additional attachments here..."></textarea>
							</aside>
							<div class="span4">
								<label class="attach_box_lbl">Notes:</label>
								<textarea class="attach_box" title="Notes" name="notes"
									cols="25" rows="10" placeholder="Enter notes here..."></textarea>
							</div>
						</div>
						<div class="pad10 pull-right" style="margin-right: 70px;">
							<button id="saveBtn" class="btn btn-primary" type="submit">
								<i class="icon icon-pencil"></i> Submit
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>