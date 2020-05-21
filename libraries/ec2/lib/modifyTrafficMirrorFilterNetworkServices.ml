open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyTrafficMirrorFilterNetworkServicesRequest =
  struct
    type t =
      {
      traffic_mirror_filter_id: String.t
        [@ocaml.doc "<p>The ID of the Traffic Mirror filter.</p>"];
      add_network_services: TrafficMirrorNetworkServiceList.t
        [@ocaml.doc
          "<p>The network service, for example Amazon DNS, that you want to mirror.</p>"];
      remove_network_services: TrafficMirrorNetworkServiceList.t
        [@ocaml.doc
          "<p>The network service, for example Amazon DNS, that you no longer want to mirror.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~traffic_mirror_filter_id  ?(add_network_services= []) 
      ?(remove_network_services= [])  ?dry_run  () =
      {
        traffic_mirror_filter_id;
        add_network_services;
        remove_network_services;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("RemoveNetworkService",
                  (TrafficMirrorNetworkServiceList.to_query
                     v.remove_network_services)));
           Some
             (Query.Pair
                ("AddNetworkService",
                  (TrafficMirrorNetworkServiceList.to_query
                     v.add_network_services)));
           Some
             (Query.Pair
                ("TrafficMirrorFilterId",
                  (String.to_query v.traffic_mirror_filter_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("remove_network_services",
               (TrafficMirrorNetworkServiceList.to_json
                  v.remove_network_services));
           Some
             ("add_network_services",
               (TrafficMirrorNetworkServiceList.to_json
                  v.add_network_services));
           Some
             ("traffic_mirror_filter_id",
               (String.to_json v.traffic_mirror_filter_id))])
    let parse xml =
      Some
        {
          traffic_mirror_filter_id =
            (Xml.required "TrafficMirrorFilterId"
               (Util.option_bind (Xml.member "TrafficMirrorFilterId" xml)
                  String.parse));
          add_network_services =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddNetworkService" xml)
                  TrafficMirrorNetworkServiceList.parse));
          remove_network_services =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveNetworkService" xml)
                  TrafficMirrorNetworkServiceList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "TrafficMirrorFilterId"
                    ([], (String.to_xml v.traffic_mirror_filter_id)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AddNetworkService"
                        ([], (TrafficMirrorNetworkServiceList.to_xml [x]))))
                v.add_network_services))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RemoveNetworkService"
                       ([], (TrafficMirrorNetworkServiceList.to_xml [x]))))
               v.remove_network_services))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyTrafficMirrorFilterNetworkServicesResult =
  ModifyTrafficMirrorFilterNetworkServicesResult
type input = ModifyTrafficMirrorFilterNetworkServicesRequest.t
type output = ModifyTrafficMirrorFilterNetworkServicesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifyTrafficMirrorFilterNetworkServices"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyTrafficMirrorFilterNetworkServicesRequest.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (ModifyTrafficMirrorFilterNetworkServicesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ModifyTrafficMirrorFilterNetworkServicesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyTrafficMirrorFilterNetworkServicesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyTrafficMirrorFilterNetworkServicesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyTrafficMirrorFilterNetworkServicesResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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