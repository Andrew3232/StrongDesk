<?php


namespace Okay\Modules\SimplaMarket\VariantsSizeColor\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;
use Okay\Core\QueryFactory;
use Okay\Modules\SimplaMarket\VariantsSizeColor\Entities\ColorAssociationsEntity;

class ColorAssociationsAdmin extends IndexAdmin
{
    public function fetch(ColorAssociationsEntity $colorAssociationsEntity, QueryFactory $queryFactory)
    {
        if($this->request->method('post') && $this->request->post('association')) {
            foreach($this->request->post('association') as $n=>$va) {
                foreach($va as $i=>$v) {
                    if(empty($color_associations[$i])) {
                        $color_associations[$i] = new \stdClass();
                    }
                    $color_associations[$i]->$n = $v;
                }
            }

            $color_associations_ids = array();

            foreach($color_associations as $association) {
                if ($association->id) {
                    $colorAssociationsEntity->update($association->id, $association);
                } else {
                    $association->id = $colorAssociationsEntity->add($association);
                }
                $color_association_ids[] = $association->id;
            }

            $delete = $queryFactory->newDelete();
            $delete->from('simplamarket_colors_associations')
                ->where('id NOT IN (:color_association_ids)')
                ->bindValue('color_association_ids', $color_associations_ids);

            $action = $this->request->post('action');
            $id = $this->request->post('action_id');

            if(!empty($action) && !empty($id)) {
                switch($action) {
                    case 'delete': {
                        $colorAssociationsEntity->delete($id);
                        break;
                    }
                }
            }
        }

        $color_associations = $colorAssociationsEntity->find();

        $this->design->assign('color_dir', '/files/originals/colors/');
        $this->design->assign('color_associations', $color_associations);

        $this->response->setContent($this->design->fetch('color_associations.tpl'));
    }

}