<?php 
namespace app\admin\controller; //定义当前类所在的命名空间
use app\admin\model\Category;
use app\admin\model\Goods;
use app\admin\model\Type;
use app\admin\model\Attribute;
use think\Db;
class GoodsController extends CommonController {



    //用于商品的编辑，查询出商品有哪些属性
    public function getGoodsTypeAttr(){
       if(request()->isAjax()){
            $goods_id = input('goods_id'); //商品id
            $type_id = input('type_id'); // 类型id
            // $goods_id = 3; //商品id
            // $type_id = 1; // 类型id
            //查询类型下面所有的属性
            $attributeData = Attribute::where("type_id",$type_id)->select()->toArray();
            //查询商品属性表
            $goodsAttrData = Db::name('goods_attr')->where('goods_id',$goods_id)->select();
            // dump($attributeData);
            // dump($goodsAttrData);die;
            //循环所有的属性$attributeData
            foreach($attributeData as $k=>$v ){
                foreach($goodsAttrData as $vv){
                    //如果$v中attr_id等于 $vv中attr_id,说明找到了属性名称下面的所有的属性
                    if($v['attr_id'] == $vv['attr_id']){
                        $attributeData[$k]['goodsAttrInfo'][] = $vv;
                    }
                    
                }
            }
            // echo "<pre />";
            // print_r($attributeData);die;
           echo json_encode($attributeData);
        }
    }


    public function ajaxDropImg(){
        //1.判断是否ajax
        if(request()->isAjax()){
            //2.接收两个参数
            $goods_id = input('goods_id');
            $path = input('path'); //原图路径  20181221/fsdfsdfa.jpg
            //3.取出当前商品的图片路径，使用json_decode变为数组格式，匹配我们要删除的图片对应的路径
            $all_img = Goods::field('goods_img,goods_middle,goods_thumb')->find($goods_id)->toArray();
            $goods_img = json_decode($all_img['goods_img']);
            $goods_middle = json_decode($all_img['goods_middle']);
            $goods_thumb = json_decode($all_img['goods_thumb']);
            foreach($goods_img as $k=>$big){
                if($big == $path){
                    //先删除物理磁盘中的文件
                    unlink("./uploads/".$goods_img[$k]);
                    unlink("./uploads/".$goods_middle[$k]);
                    unlink("./uploads/".$goods_thumb[$k]);

                    //说明找到了我们要删除的大图的路径 ，则要删除大、中、小图的路径
                    unset($goods_img[$k]);
                    unset($goods_middle[$k]);
                    unset($goods_thumb[$k]);
                    
                }
            }   

            //更新图片的路径大中小到表的字段中
            $data = [
                'goods_img' => json_encode($goods_img),
                'goods_middle' => json_encode($goods_middle),
                'goods_thumb' => json_encode($goods_thumb),    
                'goods_id' => $goods_id
            ];
            $goodsModel = new Goods();
            if($goodsModel->update($data)){
                $response = ['code'=>200,'message'=>'删除成功'];
            }else{
                $response = ['code'=>-1,'message'=>'删除失败'];
            }
           echo json_encode($response);die;
        }
        
    }


    public function upd(){
        //post编辑入库
        if(request()->isPost()){
            $postData = input('post.');
            $result = $this->validate($postData,"Goods.upd",[],true);
            if($result !== true){
                $this->error( implode(',',$result) );
            }
            //先上传图片
            $goods_img = $this->uploadImg();  // [20181212/fsdfsdf.png，20181212/fsdfsdf.png]
            if( $goods_img ){
                $thumb_img = $this->genThumbImg($goods_img); //缩略图
                //先取出来所有的图片，为了和上传成功的图片路径做一个array_merge
                $all_img = Goods::field('goods_img,goods_middle,goods_thumb')->find($postData['goods_id']);
                //都变为数组
                $ori_img =  json_decode($all_img['goods_img'])?json_decode($all_img['goods_img']):[];
                $goods_middle =  json_decode($all_img['goods_middle'])?json_decode($all_img['goods_middle']):[];
                $goods_thumb =  json_decode($all_img['goods_thumb'])?json_decode($all_img['goods_thumb']):[];
                //需要把路径合并在一起
                $new_ori_img =  array_merge($ori_img,$goods_img);
                $new_middle_img =  array_merge($thumb_img['goods_middle'],$goods_middle);
                $new_thumb_img =  array_merge($thumb_img['goods_thumb'],$goods_thumb);
                //加入表的字段中，需要入库
                $postData['goods_img'] = json_encode( $new_ori_img );
                $postData['goods_middle'] = json_encode( $new_middle_img );
                $postData['goods_thumb'] = json_encode( $new_thumb_img );
            }
            //编辑入库
            $goodsModel = new Goods();
            if($goodsModel->allowField(true)->isUpdate(true)->save($postData)){
                $this->success("编辑成功，好累",url("/admin/goods/index"));
            }else{
                $this->error("编辑失败");
            }
            
        }
        
        //1.get请求 回显数据
        $goods_id = input('goods_id');
        //取出商品的基本信息
        $goodsData = Goods::find($goods_id);
        //把图片大图的路径使用json_decode变为数组
        $goodsData['goods_img'] = json_decode($goodsData['goods_img']);
        //取出所有的商品分类,并且无限极处理
        $catModel = new Category();
        $cats = $catModel->select();
        $catsTree = $catModel->getSonsTree($cats);
        //取出所有的商品类型
        $types = Type::select();
        return $this->fetch('',[
            'goodsData' => $goodsData,
            'cats' => $catsTree,
            'types' => $types
        ]);


    }


    public function recycle(){
        //获取所有的(非回收站的)商品并分配到模板
        $goods = Goods::alias('t1')
                ->field('t1.*,t2.cat_name')
                ->join('sh_category t2','t1.cat_id = t2.cat_id','left')
                ->where('t1.is_delete',1)
                ->select();
        return $this->fetch('',[
            'goods' => $goods
        ]);
    }


    public function joinRecycle(){
        if(request()->isAjax()){
            $goods_id = input('goods_id');
            //把is_delele改为1   update() setInc()  setDec  setField
            if(Goods::where('goods_id',$goods_id)->setField('is_delete',1)){
                $response = ['code'=>200,'message'=>'加入回收站成功'];
            }else{
                $response = ['code'=>-1,'message'=>'加入回收站失败'];
            }
            echo json_encode($response);
        }
    }

	public function index(){
		//获取所有的(非回收站的)商品并分配到模板
		$goods = Goods::alias('t1')
				->field('t1.*,t2.cat_name')
				->join('sh_category t2','t1.cat_id = t2.cat_id','left')
                ->where('t1.is_delete',0)
				->select();
		return $this->fetch('',[
			'goods' => $goods
		]);
	}


	public function getTypeAttr(){
		//1.判断是否是ajax请求
		if(request()->isAjax()){
			//2.接受类型参数
			$type_id = input('type_id');
			//3.查询出此类型下面的所有的属性数据
			$attributes = Attribute::where('type_id',$type_id)->select();
			//4.响应json格式数据
			echo json_encode($attributes);
		}
	}

    
    public function add(){
    	// echo 'sn_'.time().uniqid();die;
    	//1.判断是否是post
		if(request()->isPost()){
			//2.接受参数
			$postData = input('post.');

			//3.验证器验证
			$result = $this->validate($postData,"Goods.add",[],true);
			if($result !== true){
				$this->error( implode(',',$result) );
			}
			//需要处理多文件上传操作
			$goods_img = $this->uploadImg();
			//判断是否有文件上传成功
			if($goods_img){
				//把多张图片的路径存储到数据表goods_img字段中，存json格式
				$postData['goods_img'] = json_encode($goods_img);
				//文件上传成功，进行图片的缩略图缩放
				$thumb_arr = $this->genThumbImg($goods_img);
				//把小图路径存储到表对应的字段中，进行入库操作,存储json格式
				$postData['goods_middle'] = json_encode($thumb_arr['goods_middle']);
				$postData['goods_thumb'] = json_encode($thumb_arr['goods_thumb']);

			}
			//4.写入数据库
			$goodsModel = new Goods();
			if($goodsModel->allowField(true)->save($postData)){
				$this->success("编辑成功",url("/admin/goods/index"));
			}else{
				$this->error("编辑失败");
			}
		}

    	//取出商品所有分类并分配到模板中
    	$catModel = new Category();
    	$cats = $catModel->select();
    	//无限极递归处理
    	$catsTree = $catModel->getSonsTree($cats);
    	//取出所有的商品类型，并分配到模板中
    	$types = Type::select();
    	return $this->fetch('',[
    		'cats' => $catsTree,   
    		'types' => $types
    	]);
    }


    //定义一个多文件上传的方法
    public function uploadImg(){
    	$result = []; //存储图片原图的路径
     	//1.接受文件的name名称，获取文件的信息
     	$files = request()->file('img');
     	//2.定义上传的目录，定义一些上传的要求
     	$uploadDir = "./uploads/";
     	$validate = [
     		'size' => 1024*1024*2, // 2MB
     		'ext'  => 'png,jpg,jpeg,gif'
     	];
     	//循环上传文件
     	foreach($files as $file){
     		$info = $file->validate($validate)->move($uploadDir);
     		if($info){
     			//上传成功，获取到文件名称保存到一个数组中
     			$result[] = str_replace('\\', '/', $info->getSaveName());
     		}
     		//失败可以不用理会
     	}

     	//返回结果
     	return $result;
    }


    //定义一个生产缩略图的方法
    public function genThumbImg($goods_img){
    	//$goods_img  [20181221/gsdgfsdgfsdgf.jpg,20181221/gsdgfsdgfsdgf.jpg]
    	$goods_middle = []; //存储中图的路径
    	$goods_thumb = []; //存储小图的路径

    	//生成350*350 
    	foreach($goods_img as $path){
    		//1.打开原图的路径
    		$images = \think\Image::open('./uploads/'.$path);
    		//炸开原图的路径，得到目录和图片名称
    		$arr = explode('/',$path);// [20181221,gsdgfsdgfsdgf.jpg]
    		$middle_path = $arr[0].'/middle_'.$arr[1];
    		$images->thumb(350,350,2)->save("./uploads/".$middle_path);
    		//把成功的路径存储到$goods_middle数组中
    		$goods_middle[] = $middle_path;
    	}

    	//生成50*50 
    	foreach($goods_img as $path){
    		//1.打开原图的路径
    		$images = \think\Image::open('./uploads/'.$path);
    		//炸开原图的路径，得到目录和图片名称
    		$arr = explode('/',$path);// [20181221,gsdgfsdgfsdgf.jpg]
    		$thumb_path = $arr[0].'/thumb_'.$arr[1];
    		$images->thumb(50,50,2)->save("./uploads/".$thumb_path);
    		//把成功的路径存储到$goods_thumb数组中
    		$goods_thumb[] = $thumb_path;
    	}

    	//返回中图和小图的路径
    	return [ 'goods_middle'=>$goods_middle,'goods_thumb'=>$goods_thumb ];
    }

}