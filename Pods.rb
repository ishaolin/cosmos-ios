
# 依赖库集成模式
POD_MODE_DEV     = 0  # 开发模式：以本地源码的方式集成自定义组件
POD_MODE_TEST    = 1  # 测试模式：以远程源码的方式集成自定义组件
POD_MODE_RELEASE = 2  # 发布模式：以远程源码的方式集成自定义组件，不集成DEBUG组件

def pod_github_libs()
    libs = {
        'Bugly'     => '2.5.90', # 崩溃数据收集
        'MJRefresh' => '3.6.1'   # 列表刷新     
    }
    
    libs.each do | lib, tag |
        pod lib, "#{tag}"
    end
end

def pod_custom_libs(mode)    
    libs = [
        'CXAntiSDK',
        'CXAssetsPicker',
        'CXDatabaseSDK',
        'CXDataSDK',
        'CXFoundation',
        'CXIMSDK',
        'CXIMUI',
        'CXMapKit',
        'CXNetSDK',
        'CXNotificationView',
        'CXPaySDK',
        'CXSettingKit',
        'CXShareSDK',
        'CXSocketSDK',
        'CXUIKit'
    ]
    
    libs.each do | lib |
        if mode == POD_MODE_DEV
            path = "../Pods/#{lib}/#{lib}.podspec"
            # 如果存在本地pod库文件，则从本地加载，否则从远程加载
            if File.exist?(path)
                pod lib, :path => path
            else
                pod lib
            end
        else
            pod lib
        end
    end
end

def pod_debug_libs()
    libs = {
        'Reveal-SDK' => '24' # UI结构查看工具
    }
    
    libs.each do | lib, tag |
        pod lib, "#{tag}", :configurations => ['Debug']
    end
end

def pod_test_libs()
    libs = {
        'PgyUpdate' => '1.6' # 蒲公英版本更新检查
    }
    
    libs.each do | lib, tag |
        pod lib, "#{tag}"
    end
end

def pod_libs(mode = POD_MODE_TEST)
    pod_github_libs
    pod_custom_libs(mode)
    
    case mode
        when POD_MODE_DEV
            pod_debug_libs
            pod_test_libs
        when POD_MODE_TEST
            pod_test_libs
    end
end

def remove_warnings(version)
    post_install do | installer |
    installer.pods_project.targets.each do | target |
      target.build_configurations.each do | config |
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < version.to_f
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = version
        end
      end
    end
  end
end
