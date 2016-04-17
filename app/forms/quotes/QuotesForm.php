<?php

namespace App\Forms\Quotes;

use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Date;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Numeric;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Submit;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use App\Auth\Auth;
use App\Models\Users;
use App\Models\Customers;
use App\Models\Contacts;
use App\Models\GenericStatus;

class QuotesForm extends Form
{

	/**
	 * Initiliaze the quotes form
	 */

	public function initialize()
	{
		$validation = new Validation();

		$customerCode = new Select(
			'customerCode',
			Customers::find(),
			array(
				'using' => array('customerCode', 'customerName'),
				'required'	=> 'true',
				'useEmpty'	=> true,
				'class' => 'form-control selectpicker',
				'data-live-search' => 'true',
			)
		);
		$customerCode->setLabel("Customer");
		$this->add($customerCode);

		$contact = new Select(
			'contact',
			[null => 'Select a Customer First..'],
			array(
				'using'	=> array('id', 'name'),
				'required'	=> 'true',
				'useEmpty'	=> true,
				'class'	=> 'form-control selectpicker',
				'data-live-search' => 'true',
				)
		);
		$contact->setLabel("Contact");
		$this->add($contact);

		$customerRef = new Text("customerRef");
		$customerRef->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
			));
		$customerRef->setLabel("Customer Reference");
		$this->add($customerRef);

		$date = new Date("date");
		$date->setAttributes(array(
			'required'	=> 'true',
			'class'		=> 'form-control'
			));
		$date->setLabel("Date");
		$date->setDefault(date('Y-m-d'));
		$this->add($date);

		$notes = new TextArea("notes");
		$notes->setAttributes(array(
			'class'		=> 'form-control',
			'placeholder' => 'This will be visible on the quote'
			));
		$notes->setLabel("Notes");
		$this->add($notes);

		$auth = new Auth;
		$salesAgent = new Select(
			"user",
			Users::find(),
			array(
				'using'	=> array(
					'id',
					'name'
					),
				'class'	=> 'form-control'
				)
			);
		$salesAgent->setLabel("Sales Agent");	
		$salesAgent->setDefault($auth->getId());
		$this->add($salesAgent);

		$status = new Select(
			"status",
			GenericStatus::find(),
			array(
				'using'	=> array(
					'id',
					'name'
					),
				'class'	=> 'form-control'
				)
			);
		$status->setLabel("Status");	
		$status->setDefault('1');
		$this->add($status);

		$submit = new Submit("submit");
		$submit->setAttributes(array(
			'class'	=> 'btn btn-primary'
			));
		$this->add($submit);
	}
}