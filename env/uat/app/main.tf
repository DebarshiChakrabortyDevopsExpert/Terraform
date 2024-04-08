module "az_service_plan" {
  source       = "../../../modules/az-serviceplan"
  service_plan = try(var.service_plan, {})
}

module "app_service_windows" {
  source                      = "../../../modules/az-appservice-windows"
  for_each                    = var.windows_web_app 
  windows_web_app             = try(each.value.windows_web_app, {})
  webapp_private_endpoint     = try(each.value.webapp_private_endpoint, {})
  webapp_diagnostics_settings = try(each.value.webapp_diagnostics_settings, {})
  webapp_slot                 = try(each.value.webapp_slot, {})
  webapp_private_endpoint_slot= try(each.value.webapp_private_endpoint_slot, {})
  webapp_vnets                = try(each.value.webapp_vnets, {})
  depends_on = [
    module.az_service_plan,
    module.application_insights
  ]
}

module "az_logic_app_std" {
    source             = "../../../modules/az-logicapp-standard"
    for_each           = var.logic_app_standard
    logic_app_standard = try(each.value.logic_app_standard, {})
    logic_app_std_pvt_endpnt = try(each.value.logic_app_std_pvt_endpnt, {})
    logicapp_std_diagnostics_settings = try(each.value.logicapp_std_diagnostics_settings, {})
    logic_app_std_vnets               = try(each.value.logic_app_std_vnets, {})

    depends_on = [
        module.az_service_plan
    ]
}

module "az_linux_function_app" {
  source                        = "../../../modules/az-functionapp"
  for_each                      = var.linux_function_app
  linux_function_app            = try(each.value.linux_function_app, {})
  function_app_pvt_endpnt       = try(each.value.function_app_pvt_endpnt, {})
  fun_app_diagnostics_settings  = try(each.value.fun_app_diagnostics_settings, {})
  linux_function_app_slot       = try(each.value.linux_function_app_slot, {})
  function_app_slot_pvt_endpnt  = try(each.value.function_app_slot_pvt_endpnt, {})
  func_app_vnets                = try(each.value.func_app_vnets, {})
  depends_on = [
    module.az_service_plan,
  ]
}


