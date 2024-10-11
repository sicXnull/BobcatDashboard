<?php
$info['BobcatVer'] = trim(file_get_contents("/var/dashboard/statuses/bobcat_ver"));
$uri = "https://explorer.helium.com/hotspots/".$info['PubKey'];
?>
<h1>Bobcat <?php echo $info['BobcatVer']; ?> Miner Dashboard - Information</h1>

<iframe
style="width: 100%; border-radius: 10px; box-shadow: 2px 2px 10px rgba(0,0,0,0.5);"
height="650"
frameborder="0" style="border:0"
src="<?php echo $uri; ?>" allowfullscreen>
</iframe>
