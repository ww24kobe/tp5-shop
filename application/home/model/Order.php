<?php  
namespace app\home\model;
use think\Model;

class Order extends Model{
	protected $pk = 'id';
	protected $autoWriteTimestamp = true;
	 // 数据排除字段
    protected $except = ['/home/order/writeOrderInfo'];
	
}