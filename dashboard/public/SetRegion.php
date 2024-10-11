<?php
$setRegion = trim(html_entity_decode($_POST['setregion']));

if ($setRegion != "") {
    $regionFile = fopen("/var/dashboard/region_config", "w");
    fwrite($regionFile, $setRegion);
    fclose($regionFile);

    // Run the script in the background
    shell_exec('/etc/monitor-scripts/set-region.sh > /dev/null 2>/dev/null &');

    echo 'Set Region Successfully, updating Packet Forwarder.';
} else {
    echo 'Failed to Update';
}
?>