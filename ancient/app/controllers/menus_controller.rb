class MenusController < ApplicationController#AuthCOntroller

  def access_list
    render json: {success: true, 
                  result: [{
                    name: "multilevel",
                    meta: {
                      icon: 'md-menu',
                      title: '多级菜单'
                    }
                  },{
                    name: "update",
                    meta: {
                      icon: 'md-cloud-upload',
                      title: '数据上传'
                    },
                    children: [{
                      name: "update_table_page",
                      meta: {
                        icon: 'ios-document',
                        title: '上传Csv'
                      }
                    },{
                      name: 'update_paste_page',
                      meta: {
                        icon: 'md-clipboard',
                        title: '粘贴表格数据'
                      },
                    }]
                  }]
                }
  end

end