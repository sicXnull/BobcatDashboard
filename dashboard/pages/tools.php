<?php
$info['BobcatVer'] = trim(file_get_contents("/var/dashboard/statuses/bobcat_ver"));
?>
<h1>Bobcat <?php echo $info['BobcatVer']; ?> Miner Dashboard - Tools</h1>

<div id="tools_buttons">
	<ul>
		<li id="password_reset_button">
			<a href="#" onclick="ResetPasswordPrompt();" title="Reset Password">
				<span class="icon-key"></span>
				<span class="button_title">Reset Password</span>
			</a>
		</li>

		<li id="set_wireless_button">
			<a href="#" onclick="SetWirelessPrompt();" title="Set WiFi">
				<span class="icon-wifi"></span>
				<span class="button_title">Set WiFi</span>
			</a>
		</li>

		<li id="update_dashboard_button">
			<a href="/index.php?page=updatedashboard" title="Update Dashboard">
				<span class="icon-system_update_tv"></span>
				<span class="button_title">Update Dashboard</span>
			</a>
		</li>

		<li id="update_miner_button">
			<a href="/index.php?page=updateminer" title="Update Miner">
				<span class="icon-cloud-check"></span>
				<span class="button_title">Update Miner</span>
			</a>
		</li>

		<li id="set_timezone_button">
			<a href="#" onclick="SetTimezonePrompt();" title="Set Timezone">
				<span class="icon-time"></span>
				<span class="button_title">Set Timezone</span>
			</a>
		</li>
		
		<li id="set_region_button">
			<a href="#" onclick="SetRegionPrompt();" title="Set Region">
				<img src="images/earth.png" alt="Set Region" style="width: 16px; height: 16px;" />
				<span class="button_title">Set Region</span>
			</a>
		</li>
		
		<li id="server_detection_button">
			<a href="/index.php?page=serverdetection" title="Server Detection">
				<span class="icon-hammer"></span>
				<span class="button_title">Server Detection</span>
			</a>
		</li>
	</ul>
</div>
