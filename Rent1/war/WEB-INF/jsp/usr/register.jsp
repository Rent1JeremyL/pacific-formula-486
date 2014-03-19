<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<head>
<link rel="stylesheet" href="/webincludes/css/style.css">
<link rel="stylesheet" href="/webincludes/css/font-awesome.min.css">
<link rel="stylesheet" href="/webincludes/css/rent1.css">

<link rel="stylesheet" href="/webincludes/css/production-uri.css">
<link rel="stylesheet" href="/webincludes/css/lightboxes-uri.css">
</head>
<body>
	<div id="fb-root"></div>
	<div id="alt-content"></div>
	<div id="main" class="jumbotron masthead home">
		<div id="lightbox-outer" class="">
			<div id="lightbox" class="lightbox-signup" style="width: 320px;">
				<a id="lightbox-close"
					class="close btn btn-rounded btn-icon-only btn-dark" href="/"><i
					class="icon icon-ex-white-outline"></i></a>
				<div id="lightbox-inner">
					<div class="lbcontainer">
						<div id="lightbox-header">
							<h2 class="title">Sign Up for RENT1</h2>
						</div>
						<form action="/register/add/user" method="POST">
							<div id="lightbox-content" style="max-height: 450px;">
								<div class="lightbox-content-block">
									<div id="signup-stage-signup" class="signup-stage">
										<div class="section-title">
											<h3>Connect With</h3>
										</div>
										<div id="login-third-party"
											style="text-align: center; width: 50%; margin: 10 auto;">
											<a id="lb-google-login"
												class="btn share-btn third-party google last"> <i
												class="icon icon-google-plus-white-flat"></i> <span
												class="text"> Google </span>
											</a>
										</div>
										<div class="section-title">
											<h3>or</h3>
										</div>
										<div class="control-group">
											<div style="color: #FF0000;">${errorMessage}</div>
											<div class="controls">
												<label class="placeholder-text" for="signup-email">*Email
													Address</label> <input id="signup-email" class="input-box-text"
													name="signup-email" type="email" required>
											</div>
										</div>
										<div class="control-group">
											<div class="controls">
												<label class="placeholder-text" for="signup-password1">*Password</label>
												<input id="signup-password1" name="signup-password1"
													class="signup-text placeholder-input" type="password" required>
											</div>
										</div>
										<div class="control-group">
											<div class="controls">
												<label class="placeholder-text" for="signup-password1">*Confirm
													Password</label> <input id="signup-password2"
													name="signup-password2"
													class="signup-text placeholder-input" type="password" required>
											</div>
										</div>
										<div id="signup-user-type" class="btn-group"></div>
										<p class="tos">
											By clicking Create Account, you are agreeing to the <a
												href="#">RENT1 Terms of Service</a>
										</p>
									</div>
								</div>
							</div>
							<div id="lightbox-footer">
								<button id="createAcct"
									class="btn btn-large btn-primary btn-fullwidth" type="submit">Create
									Account</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div id="lightbox-overlay" class=""></div>
		<div id="header-container"></div>
		<div id="stage" class="theme"></div>
		<div id="player-wrapper" class="queue-closed"></div>
	</div>
</body>
</html>