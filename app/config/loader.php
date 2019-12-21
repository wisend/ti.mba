<?php

$loader = new \Phalcon\Loader();

date_default_timezone_set('NZ');

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerNamespaces(
	array(
        'App\Controllers'           => $config->application->controllersDir,
		'App\Controllers\Mobile'	=> $config->application->mobileControllersDir,
		'App\Models' 		        => $config->application->modelsDir,
		'App\Forms' 		        => $config->application->formsDir,
		'App' 				        => $config->application->libraryDir,
	)
)->register();

// Register some classes
$loader->registerClasses(
    array(
        'Elements'		=> __DIR__ . '/../library/Elements.php'
    )
)->register();


// Register composer autoloader
require_once((__DIR__) . '/../../vendor/autoload.php');
$elements = new Elements();
