open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyCurrentDBClusterCapacityMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The DB cluster identifier for the cluster being modified. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DB cluster.</p> </li> </ul>"];
      capacity: Integer.t option
        [@ocaml.doc
          "<p>The DB cluster capacity.</p> <p>When you change the capacity of a paused Aurora Serverless DB cluster, it automatically resumes.</p> <p>Constraints:</p> <ul> <li> <p>For Aurora MySQL, valid capacity values are <code>1</code>, <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>128</code>, and <code>256</code>.</p> </li> <li> <p>For Aurora PostgreSQL, valid capacity values are <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>192</code>, and <code>384</code>.</p> </li> </ul>"];
      seconds_before_timeout: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in seconds, that Aurora Serverless tries to find a scaling point to perform seamless scaling before enforcing the timeout action. The default is 300.</p> <ul> <li> <p>Value must be from 10 through 600.</p> </li> </ul>"];
      timeout_action: String.t option
        [@ocaml.doc
          "<p>The action to take when the timeout is reached, either <code>ForceApplyCapacityChange</code> or <code>RollbackCapacityChange</code>.</p> <p> <code>ForceApplyCapacityChange</code>, the default, sets the capacity to the specified value as soon as possible.</p> <p> <code>RollbackCapacityChange</code> ignores the capacity change if a scaling point isn't found in the timeout period.</p>"]}
    let make ~d_b_cluster_identifier  ?capacity  ?seconds_before_timeout 
      ?timeout_action  () =
      {
        d_b_cluster_identifier;
        capacity;
        seconds_before_timeout;
        timeout_action
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timeout_action
              (fun f -> ("timeout_action", (String.to_json f)));
           Util.option_map v.seconds_before_timeout
             (fun f -> ("seconds_before_timeout", (Integer.to_json f)));
           Util.option_map v.capacity
             (fun f -> ("capacity", (Integer.to_json f)));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          capacity =
            (Util.option_bind (Xml.member "Capacity" xml) Integer.parse);
          seconds_before_timeout =
            (Util.option_bind (Xml.member "SecondsBeforeTimeout" xml)
               Integer.parse);
          timeout_action =
            (Util.option_bind (Xml.member "TimeoutAction" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBClusterIdentifier"
                    ([], (String.to_xml v.d_b_cluster_identifier)))])
             @
             [Util.option_map v.capacity
                (fun f -> Ezxmlm.make_tag "Capacity" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.seconds_before_timeout
               (fun f ->
                  Ezxmlm.make_tag "SecondsBeforeTimeout"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.timeout_action
              (fun f ->
                 Ezxmlm.make_tag "TimeoutAction" ([], (String.to_xml f)))])
  end
module DBClusterCapacityInfo = DBClusterCapacityInfo
type input = ModifyCurrentDBClusterCapacityMessage.t
type output = DBClusterCapacityInfo.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["ModifyCurrentDBClusterCapacity"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyCurrentDBClusterCapacityMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyCurrentDBClusterCapacityMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyCurrentDBClusterCapacityResponse" (snd xml))
        (Xml.member "ModifyCurrentDBClusterCapacityResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBClusterCapacityInfo.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DBClusterCapacityInfo."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterCapacityInfo - missing field in body or children: "
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