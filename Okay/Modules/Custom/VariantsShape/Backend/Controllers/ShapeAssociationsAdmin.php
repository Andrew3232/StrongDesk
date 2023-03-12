<?php


namespace Okay\Modules\Custom\VariantsShape\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;
use Okay\Core\QueryFactory;
use Okay\Modules\Custom\VariantsShape\Entities\ShapeAssociationsEntity;

class ShapeAssociationsAdmin extends IndexAdmin
{
    public function fetch(ShapeAssociationsEntity $shapeAssociationsEntity, QueryFactory $queryFactory)
    {
        if($this->request->method('post') && $this->request->post('association')) {
            foreach($this->request->post('association') as $n=>$va) {
                foreach($va as $i=>$v) {
                    if(empty($shape_associations[$i])) {
                        $shape_associations[$i] = new \stdClass();
                    }
                    $shape_associations[$i]->$n = $v;
                }
            }

            $shape_associations_ids = array();

            foreach($shape_associations as $association) {
                if ($association->id) {
                    $shapeAssociationsEntity->update($association->id, $association);
                } else {
                    $association->id = $shapeAssociationsEntity->add($association);
                }
                $shape_association_ids[] = $association->id;
            }

            $delete = $queryFactory->newDelete();
            $delete->from('custom_shapes_associations')
                ->where('id NOT IN (:shape_association_ids)')
                ->bindValue('shape_association_ids', $shape_associations_ids);

            $action = $this->request->post('action');
            $id = $this->request->post('action_id');

            if(!empty($action) && !empty($id)) {
                switch($action) {
                    case 'delete': {
                        $shapeAssociationsEntity->delete($id);
                        break;
                    }
                }
            }
        }

        $shape_associations = $shapeAssociationsEntity->find();

        $this->design->assign('shape_associations', $shape_associations);

        $this->response->setContent($this->design->fetch('shape_associations.tpl'));
    }
}