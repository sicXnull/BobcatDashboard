<?php
if (isset($_POST['SSID']) && isset($_POST['password']) && 
    ($_POST['SSID'] != '' && $_POST['password'] != "")) {

    $ssid = trim(html_entity_decode($_POST['SSID']));
    $password = trim(html_entity_decode($_POST['password']));

    $response = "";

    $iwctlCommand = "sudo iwctl station wlan0 connect '$ssid' --passphrase '$password'";
    exec($iwctlCommand . " 2>&1", $iwctlOutput, $iwctlReturnVar);

    if ($iwctlReturnVar === 0) {
        $response .= "Connected to Wi-Fi network: " . htmlentities($ssid) . ". ";
        
        $dhclientCommand = "sudo dhclient wlan0";
        exec($dhclientCommand . " 2>&1", $dhclientOutput, $dhclientReturnVar);

        if ($dhclientReturnVar === 0) {
            $response .= "DHCP client started successfully on wlan0.";
        } else {
            $response .= "Error starting DHCP client: " . implode("\n", $dhclientOutput);
        }
    } else {
        $response .= "Error connecting to Wi-Fi network: " . implode("\n", $iwctlOutput);
    }

    echo $response;

} else {
    echo 'Error, please provide both SSID and password.';
}
?>
