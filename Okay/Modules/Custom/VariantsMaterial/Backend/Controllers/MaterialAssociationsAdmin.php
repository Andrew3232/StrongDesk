<?php


namespace Okay\Modules\Custom\VariantsMaterial\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;
use Okay\Core\QueryFactory;
use Okay\Modules\Custom\VariantsMaterial\Entities\MaterialAssociationsEntity;

class MaterialAssociationsAdmin extends IndexAdmin
{
    public function fetch(MaterialAssociationsEntity $materialAssociationsEntity, QueryFactory $queryFactory)
    {
        if($this->request->method('post') && $this->request->post('association')) {
            foreach($this->request->post('association') as $n=>$va) {
                foreach($va as $i=>$v) {
                    if(empty($material_associations[$i])) {
                        $material_associations[$i] = new \stdClass();
                    }
                    $material_associations[$i]->$n = $v;
                }
            }

            $material_associations_ids = array();

            foreach($material_associations as $association) {
                if ($association->id) {
                    $materialAssociationsEntity->update($association->id, $association);
                } else {
                    $association->id = $materialAssociationsEntity->add($association);
                }
                $material_association_ids[] = $association->id;
            }

            $delete = $queryFactory->newDelete();
            $delete->from('custom_materials_associations')
                ->where('id NOT IN (:material_association_ids)')
                ->bindValue('material_association_ids', $material_associations_ids);

            $action = $this->request->post('action');
            $id = $this->request->post('action_id');

            if(!empty($action) && !empty($id)) {
                switch($action) {
                    case 'delete': {
                        $materialAssociationsEntity->delete($id);
                        break;
                    }
                }
            }
        }

        $material_associations = $materialAssociationsEntity->find();

        $this->design->assign('material_associations', $material_associations);

        $this->response->setContent($this->design->fetch('material_associations.tpl'));
    }
}