<?php
if(isset($_GET['name']))
{
	switch($_GET['name'])
	{
		case 'miner-update':
			echo trim(file_get_contents('/var/dashboard/services/miner-update'));
			break;

		case 'dashboard-update':
			echo trim(file_get_contents('/var/dashboard/services/dashboard-update'));
			break;

		case 'clear-blockchain':
			echo trim(file_get_contents('/var/dashboard/services/clear-blockchain'));
			break;

		case 'server-detection':
			echo trim(file_get_contents('/var/dashboard/services/server-detection'));
			break;
	}
}
?>
