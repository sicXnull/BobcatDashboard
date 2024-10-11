<?php
$page = htmlentities(strip_tags($_GET['page']));
$info['AnimalName'] = trim(file_get_contents("/var/dashboard/statuses/animal_name"));
$info['PubKey'] = trim(file_get_contents("/var/dashboard/statuses/pubkey"));
$info['OnlineStatus'] = trim(file_get_contents("/var/dashboard/statuses/online_status"));
$info['CurrentBlockHeight'] = trim(file_get_contents("/var/dashboard/statuses/current_blockheight"));
$info['Version'] = trim(file_get_contents("/var/dashboard/version"));
$info['Update'] = trim(file_get_contents("/var/dashboard/update"));
$info['MinerVersion'] = trim(file_get_contents('/var/dashboard/statuses/current_miner_version'));
$info['LatestMinerVersion'] = trim(file_get_contents('/var/dashboard/statuses/latest_miner_version'));
$info['BobcatVer'] = trim(file_get_contents("/var/dashboard/statuses/bobcat_ver"));
$info['FirmwareVersion'] = trim(file_get_contents("/etc/ota_version"));
include('../pages/first-load.php');
if (file_exists('/opt/bobcat/data/SN')) {
    $info['BobcatXSN'] = trim(file_get_contents("/opt/bobcat/data/SN"));
}
else
{
    $info['BobcatXSN'] = 'Unknown';
}

$sync = '<li><p style="color:#2BFF97">Fully Synced</p></li><br />';
?>
<!DOCTYPE html>
<html>
<head>
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/common.css" />
<link rel="stylesheet" href="css/fonts.css" />
<link rel="stylesheet" href="css/hack.css" />
<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/functions.js"></script>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-8NGJ6M5PSV"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-8NGJ6M5PSV');
</script>
<?php
if ($info['BobcatVer'] == 'X1') {
    echo '<link rel="shortcut icon" href="favicon-x1.ico" type="image/x-icon" />';
} elseif ($info['BobcatVer'] == 'X2') {
    echo '<link rel="shortcut icon" href="favicon-x2.ico" type="image/x-icon" />';
}
?>

<title>Bobcat <?php echo $info['BobcatVer']; ?> Miner Dashboard</title>
</head>

<body>
	<header>
		<div id="logo_container">
			<a href="/index.php" title="Home"><img src="images/logo.png" /></A>
		</div>

		<div id="power_container">
			<a href="#" title="Reboot miner" onclick="RebootDevice();"><span class="icon-switch"></span></a>
		</div>

		<br class="clear" />
	</header>

	<div id="main">
		<nav>
			<ul>
				<li <?php if($page == 'home' || $page == '') { echo 'class="active_page"'; } ?>><a href="/index.php" title="Homepage"><span class="icon-home"></span><span class="text">Home</span></a></li>
				<li <?php if($page == 'tools') { echo 'class="active_page"'; } ?>><a href="/?page=tools" title="Tools"><span class="icon-wrench"></span><span class="text">Tools</span></a></li>
				<li <?php if($page == 'info') { echo 'class="active_page"'; } ?>><a href="/?page=info" title="Information"><span class="icon-info"></span><span class="text">Info</span></a></li>
				<li <?php if($page == 'logs' || $page == 'minerloganalyzer' || $page == 'lorapacketforwarderanalyzer') { echo 'class="active_page"'; } ?>><a href="/?page=logs" title="Logs"><span class="icon-list"></span><span class="text">Logs</span></a></li>
			</ul>

		</nav>

		<section id="content">
			<?php
			switch($page)
			{
				case 'home':
					include('/var/dashboard/pages/home.php');
					break;

				case 'tools':
					include('/var/dashboard/pages/tools.php');
					break;

				case 'info':
					include('/var/dashboard/pages/info.php');
					break;

				case 'logs':
					include('/var/dashboard/pages/helium-miner-log.php');
					include('/var/dashboard/pages/packet-forwarder-log.php');
					include('/var/dashboard/pages/logs.php');
					break;

				case '404':
					include('/var/dashboard/pages/404.php');
					break;

				case 'rebooting':
					include('/var/dashboard/pages/rebooting.php');
					break;
				case 'updateminer':
					include('/var/dashboard/pages/updateminer.php');
					break;

				case 'serverdetection':
					include('/var/dashboard/pages/serverdetection.php');
					break;

				case 'updatedashboard':
					include('/var/dashboard/pages/updatedashboard.php');
					break;

				case 'minerloganalyzer':
					// Light version: https://engineering.helium.com/2022/05/10/miner-firmware-hotspot-release.html
					if (strstr($info['LatestMinerVersion'], 'gateway'))
					    include('/var/dashboard/pages/minergatewayrsloganalyzer.php');
					elseif ($info['LatestMinerVersion'] != '' && (strcmp($info['LatestMinerVersion'], 'miner-arm64_2022.05.10.0_GA') < 0))
						include('/var/dashboard/pages/minerloganalyzer.php');
					else
						include('/var/dashboard/pages/minerlightloganalyzer.php');
					break;

				case 'lorapacketforwarderanalyzer':
					include('/var/dashboard/pages/lorapacketforwarderanalyzer.php');
					break;

				default:
					include('/var/dashboard/pages/home.php');
					break;
			}
			?>
		</section>

		<section id="status_panel">
			<div id="info_height_panel">
				<span class="icon-grid"></span>
				<h3>Online Status</h3>
				<ul id="online_status">
					<?php echo $sync ?>
					<li>: <span id=""></span></li>
				</ul>
			</div>

			<div id="public_key_panel">
				<span class="icon-key"></span>
				<h3>Public Key</h3>
				<div id="public_key_data"><?php echo '<a href="https://explorer.helium.com/hotspots/'.$info['PubKey'].'">'.ucwords($info['AnimalName']).'</a>'; ?></div>
			</div>
		</section>
<footer style="text-align: center;">

    <a href="https://github.com/sicXnull/BobcatDashboard">Dashboard</a> Version: <?php echo $info['Version']; ?>
</footer>
		<br class="clear" />
	</div>
</body>
</html>
