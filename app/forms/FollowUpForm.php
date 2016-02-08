<?php

namespace App\Forms;

use Phalcon\Forms\Form,
	Phalcon\Forms\Element\Text,
	Phalcon\Forms\Element\TextArea,
	Phalcon\Forms\Element\Date,
	Phalcon\Forms\Element\Select,
	Phalcon\Forms\Element\Submit;

use App\Auth\Auth;

use App\Models\Customers,
	App\Models\Contacts,
	App\Models\Users;

class FollowUpForm extends Form
{
	// Initialize the Follow Up form
	public function initialize()
	{
		$customer = new Select(
			"customerCode",
			Customers::find(),
			array(
				'using'	=> array(
					'customerCode',
					'customerName'
				),
			'class'	=> 'form-control'
			)
		);
		$customer->setLabel("Customer");
		$this->add($customer);

		$contact = new Select(
			"contact",
			Contacts::find(),
			array(
				'using'	=> array(
					'id',
					'name'
				),
			'class'	=> 'form-control'
			)
		);
		$contact->setLabel("Contact");
		$this->add($contact);

		$job = new Text("job");
		$job->setAttributes(array(
			'class'		=> 'form-control'
			));
		$job->setLabel("Job");
		$this->add($job);

		$details = new TextArea("details");
		$details->setAttributes(array(
			'class'		=> 'form-control'
			));
		$details->setLabel("Details");
		$this->add($details);

		$date = new Date("date");
		$date->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
			));
		$date->setLabel("Date");
		$this->add($date);
		
		$auth = new Auth();

		$rep = new Select(
			"user",
			Users::find(),
			array(
				'using'	=> array(
					'id',
					'name'
				),
			"required"	=> "true",
			"class"		=> "form-control",
			"default"	=> $auth->getId(),
			)
		);
		$rep->setLabel("Sales Rep");
		$this->add($rep);

		$submit = new Submit("submit");
		$this->add($submit);
	}
}