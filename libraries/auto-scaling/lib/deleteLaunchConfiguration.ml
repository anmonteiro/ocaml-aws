open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module LaunchConfigurationNameType =
  struct
    type t =
      {
      launch_configuration_name: String.t
        [@ocaml.doc "<p>The name of the launch configuration.</p>"]}
    let make ~launch_configuration_name  () = { launch_configuration_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("launch_configuration_name",
                (String.to_json v.launch_configuration_name))])
    let parse xml =
      Some
        {
          launch_configuration_name =
            (Xml.required "LaunchConfigurationName"
               (Util.option_bind (Xml.member "LaunchConfigurationName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "LaunchConfigurationName"
                 ([], (String.to_xml v.launch_configuration_name)))])
  end
module Output = Aws.BaseTypes.Unit
type input = LaunchConfigurationNameType.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]);
         ("Action", ["DeleteLaunchConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (LaunchConfigurationNameType.to_query req))))) in
  (`POST, uri, (Headers.render (LaunchConfigurationNameType.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None