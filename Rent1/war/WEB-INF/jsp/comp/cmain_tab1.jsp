<%@page contentType="text/html;charset=UTF-8" language="java"%>

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