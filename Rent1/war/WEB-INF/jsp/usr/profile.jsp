<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.rent1.entity.User"%>
<%@page import="com.rent1.dao.UserDao"%>

<head>
<meta charset="utf-8">
<title>RENT1 - Profile</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="description">
<meta content="" name="author">

<link rel="stylesheet" href="/webincludes/css/bootstrap.css">
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">

<link rel="icon" type="image/png" href="/favicon.ico">
<!-- javascript load bootstrap elements =============== -->
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script src="/webincludes/js/bootstrap.min.js"></script>
<!-- ================================================== -->
<!-- ==== START [Google Map Engine] -->
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<!-- ==== END [Google Map Engine] -->
<script src="/webincludes/js/rent1.js"></script>
<script type='text/javascript'>
	$(function() {
		var componentForm = {
			street_number : 'short_name',
			route : 'long_name',
			locality : 'long_name',
			administrative_area_level_1 : 'long_name',
			country : 'long_name',
			postal_code : 'short_name'
		};

		var autocomplete = new google.maps.places.Autocomplete(
		/** @type {HTMLInputElement} */
		(document.getElementById('location')), {
			types : [ 'geocode' ]
		});

		google.maps.event.addListener(autocomplete, 'place_changed',
				function() {
					fillInAddress(componentForm, autocomplete);
					mergeAddress();
				});
	});

	function editPass(on) {
		if (on == 1) {
			document.getElementById("view-pass").style.display = 'none';
			document.getElementById("change-pass").style.display = 'block';
			document.getElementById("edit-pass").required = !this.checked;
			document.getElementById("edit-pass-new").required = !this.checked;
			document.getElementById("edit-pass-con").required = !this.checked;
		} else {
			document.getElementById("view-pass").style.display = 'block';
			document.getElementById("change-pass").style.display = 'none';
			document.getElementById("edit-pass-new").value = '';
			document.getElementById("edit-pass-con").value = '';
			document.getElementById("edit-pass").required = this.checked;
			document.getElementById("edit-pass-new").required = this.checked;
			document.getElementById("edit-pass-con").required = this.checked;
		}
	}

	function mergeAddress() {
		var address = document.getElementById("street_number").value;
		var street = document.getElementById("route").value;

		document.getElementById('street-full').value = address + ' ' + street;
		document.getElementById('street-full').disabled = false;
	}
</script>
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
	%>
	<div class="content" style="background: #D8D8D8; color: black;">
		<div class="jumbotron home bg-img"></div>
		<div class="det_container box_outset">
			<div id="profile" class="profile_box_inset row"
				style="background-color: #EEEEEE">
				<form action="/save-profile" method="post">
					<div class="section-title_h">
						<h3 id="h3-name">
							<%=user.getNickName()%>'s Profile
						</h3>
					</div>
					<div class="section-title_h">
						<h4
							class="blocksubhead subsectionhead userprof_headers userprof_headers_border">
							Basic Information <a
								onClick="toggle_visibility('upd-local');toggle_visibility('upd-local2');toggle_visibility('upd-local3')"
								style="font-size: 80%"> (update)</a>
						</h4>
					</div>
					<div class="control-group">
						<dl>
							<dt class="prof_h1_left">Email Address:</dt>
							<dd class="prof_input_right">
								<input id="signup-email" name="signup-email"
									class="input-large placeholder-input has-text" type="text"
									disabled="disabled" value="<%=user.getEmail()%>">
							</dd>
						</dl>
						<dl>
							<dt class="prof_h1_left">Nickname:</dt>
							<dd class="prof_input_right">
								<input id="prof-nickname" name="prof-nickname"
									class="input-large" type="text" value="<%=user.getNickName()%>"
									required>
							</dd>
						</dl>
						<%
							// Allow password edits only if not linked to Google	
							if (user.getGoogleId() == null) {
						%>
						<div id="view-pass" class="control" style="display: block;">
							<dl>
								<dt class="prof_h1_left">
									Password: <a onclick="editPass(1)" style="font-weight: normal">
										change </a>
								</dt>
								<dd class="prof_input_right">
									<input id="prof-pass" name="prof-pass"
										class="input-large placeholder-input has-text" type="password"
										disabled="disabled" value="********">
								</dd>
							</dl>
						</div>
						<div id="change-pass" class="control" style="display: none;">
							<dl>
								<dt class="prof_h1_left">
									*Password: <a onclick="editPass(0)" style="font-weight: normal">
										cancel </a>
								</dt>
								<dd class="prof_input_right">
									<input id="edit-pass" name="edit-pass"
										class="input-large placeholder-input has-text" type="password"
										value="">
								</dd>
							</dl>
							<dl>
								<dt class="prof_h1_left">*New:</dt>
								<dd class="prof_input_right">
									<input id="edit-pass-new" name="edit-pass-new"
										class="input-large placeholder-input has-text" type="password"
										value="">
								</dd>
							</dl>
							<dl>
								<dt class="prof_h1_left">*Confirm:</dt>
								<dd class="prof_input_right">
									<input id="edit-pass-con" name="edit-pass-con"
										class="input-large placeholder-input has-text" type="password"
										value="">
								</dd>
							</dl>
						</div>
						<%
							}
						%><dl>
							<dt class="prof_h1_left">First Name:</dt>
							<dd class="prof_input_right">
								<input id="prof-first" name="prof-first"
									class="input-large placeholder-input has-text" type="text"
									value="<%=user.getFirstName()%>"></input>
							</dd>
						</dl>
						<dl>
							<dt class="prof_h1_left">Last Name:</dt>
							<dd class="prof_input_right">
								<input id="prof-last" name="prof-last"
									class="input-large placeholder-input has-text" type="text"
									value="<%=user.getLastName()%>"></input>
							</dd>
						</dl>
						<dl>
							<dt class="prof_h1_left">Phone Number:</dt>
							<dd class="prof_input_right">
								<input id="prof-tel" name="prof-tel"
									class="input-large placeholder-input has-text" type="tel"
									placeholder="000-000-0000" value="<%=user.getPhone()%>"></input>
							</dd>
						</dl>
					</div>
					<div class="search-horizontal">
						<div class="section-title_h">
							<span>
								<h4
									class="blocksubhead subsectionhead userprof_headers userprof_headers_border">
									Address Information <a
										onClick="toggle_visibility('upd-local');toggle_visibility('upd-local2');toggle_visibility('upd-local3')"
										style="font-size: 80%"> (update)</a>
								</h4>
							</span>
						</div>
						<div id="upd-local" style="display: none;"
							class="span11 search-horizontal">
							<div class="form-horizontal well span6"
								style="margin-left: 60px; height: 35px;">
								<div class="rental-wrap wrap">
									<input id="location" name="location"
										placeholder="Enter your address" onFocus="geolocate()"
										type="text"> <span class="icon-globe"></span>
								</div>
							</div>
						</div>
						<div class="pad10">
							<p class="prof_h1_left">Street:</p>
							<input id="street-full"
								class="input-large placeholder-input has-text"
								name="street-full" value="<%=user.getAddress().getStreet1()%>"
								disabled="disabled" type="text">
							<div style="display: none;">
								<input id="street_number"
									class="span2 placeholder-input has-text" name="street_number"
									value="" disabled="disabled" type="text"> <input
									id="route" class="input-large placeholder-input has-text"
									name="route" value="" disabled="disabled"
									onchange="mergeAddress()" type="text">
							</div>
						</div>
						<div class="pad10">
							<p class="prof_h1_left">City:</p>
							<input id="locality"
								class="input-large placeholder-input has-text" name="locality"
								value="<%=user.getAddress().getCity()%>" disabled="disabled" type="text">
						</div>
						<div class="pad10">
							<p class="prof_h1_left">State/Province:</p>
							<input id="administrative_area_level_1"
								class="input-large placeholder-input has-text"
								name="administrative_area_level_1" value="<%=user.getAddress().getState()%>"
								disabled="disabled" type="text">
						</div>
						<div class="pad10">
							<p class="prof_h1_left">Zip/Post Code:</p>
							<input id="postal_code"
								class="input-large placeholder-input has-text"
								name="postal_code" value="<%=user.getAddress().getPostCode()%>"
								disabled="disabled" type="text">
						</div>
						<div class="pad10">
							<p class="prof_h1_left">Country:</p>
							<input id="country"
								class="input-large placeholder-input has-text" name="country"
								value="<%=user.getAddress().getCountry()%>" disabled="disabled" type="text">
						</div>
						<div id="upd-local2" class="pad10 has-text"
							style="margin-left: 100px; display: none;">
							<input type="checkbox" id="confirm" name="confirm"
								value="confirm" required><i> I have reviewed the
								above and confirm the infromation given is correct</i><br>
						</div>
						<div id="upd-local3" class="pad10" style="display: none;">
							<button id="saveBtn" class="btn btn-primary"
								style="margin-left: 180px;" type="submit">
								<i class="icon icon-pencil"></i> Save
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@include file='/WEB-INF/jsp/footer.jsp'%>
</body>