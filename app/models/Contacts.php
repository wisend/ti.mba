<?php

namespace App\Models;

use Phalcon\Mvc\Model;
use App\Models\ContactRecord;
use App\Plugins\Auth\Auth;

class Contacts extends Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $customerCode;

    /**
     *
     * @var string
     */
    public $firstName;

    /**
     *
     * @var string
     */
    public $lastName;

    /**
     *
     * @var string
     */
    public $email;

    /**
     *
     * @var string
     */
    public $directDial;

    /**
     *
     * @var string
     */
    public $cellPhone;

    /**
     *
     * @var string
     */
    public $position;


    /**
     *
    * @var int
    */
    public $role;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->belongsTo('customerCode', 'App\Models\Customers', 'customerCode', array('alias'  => 'company'));
        $this->hasMany('id', 'App\Models\ContactRecords', array('alias' => 'history'));
        $this->hasOne('role', 'App\Models\ContactRoles', 'id', array('alias'  => 'job'));
    }

    /**
     * Clear custom position on update
     * Contact role is required instead
     */
    public function beforeUpdate()
    {
        $this->position = null;
    }

    public static function searchColumns($search)
    {
        $query = self::query();
        $query->where('name LIKE :search: OR directDial LIKE :search:');
        $query->orderBy('customerCode ASC');
        $query->bind(['search' => '%' . $search . '%']);
        return $query->execute();
    }
}
