<?php
if (isset($_POST['SSID']) && isset($_POST['password']) && 
    ($_POST['SSID'] != '' && $_POST['password'] != "")) {

    // Sanitize input
    $ssid = escapeshellarg(trim(html_entity_decode($_POST['SSID'])));
    $password = escapeshellarg(trim(html_entity_decode($_POST['password'])));

    $response = "";
    // Check if already connected to a Wi-Fi network
    $checkConnectedCommand = "nmcli -t -f DEVICE,TYPE,STATE device | grep wifi | grep connected";
    exec($checkConnectedCommand, $connectedOutput, $connectedReturnVar);

    if ($connectedReturnVar === 0) {
        // A Wi-Fi connection is already active, disconnect it
        $response .= 'Active Wi-Fi connection found. Disconnecting... ';
        $disconnectCommand = "sudo nmcli device disconnect wifi";
        exec($disconnectCommand, $disconnectOutput, $disconnectReturnVar);

        if ($disconnectReturnVar === 0) {
            $response .= 'Disconnected successfully. ';
        } else {
            $response .= 'Warning: Could not disconnect active Wi-Fi connection. ';
        }
    }

    // Delete all existing Wi-Fi connections
    $response .= 'Cleaning up old Wi-Fi connections... ';
    $deleteCommand = "sudo nmcli connection show | grep wifi | awk '{print $1}' | xargs -r sudo nmcli connection delete";
    exec($deleteCommand, $deleteOutput, $deleteReturnVar);

    if ($deleteReturnVar === 0) {
        $response .= 'All existing Wi-Fi connections removed. ';
    } else {
        $response .= 'Error deleting Wi-Fi connections. ';
    }

    // Connect to the new Wi-Fi network
    $response .= "Connecting to Wi-Fi network: " . htmlentities($_POST['SSID']) . "... ";
    $command = "sudo nmcli device wifi connect $ssid password $password";
    exec($command, $output, $return_var);

    if ($return_var === 0) {
        $response .= 'Connected successfully!';
    } else {
        $response .= 'Error connecting to Wi-Fi.';
    }

    echo $response;

} else {
    echo 'Error, please provide both SSID and password.';
}
?>
