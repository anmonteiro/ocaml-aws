open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBSubnetGroupMessage =
  struct
    type t =
      {
      d_b_subnet_group_name: String.t
        [@ocaml.doc
          "<p>The name for the DB subnet group. This value is stored as a lowercase string. You can't modify the default subnet group. </p> <p>Constraints: Must match the name of an existing DBSubnetGroup. Must not be default.</p> <p>Example: <code>mySubnetgroup</code> </p>"];
      d_b_subnet_group_description: String.t option
        [@ocaml.doc "<p>The description for the DB subnet group.</p>"];
      subnet_ids: SubnetIdentifierList.t
        [@ocaml.doc "<p>The EC2 subnet IDs for the DB subnet group.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_subnet_group_name  ?d_b_subnet_group_description 
      ~subnet_ids  () =
      { d_b_subnet_group_name; d_b_subnet_group_description; subnet_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_ids", (SubnetIdentifierList.to_json v.subnet_ids));
           Util.option_map v.d_b_subnet_group_description
             (fun f -> ("d_b_subnet_group_description", (String.to_json f)));
           Some
             ("d_b_subnet_group_name",
               (String.to_json v.d_b_subnet_group_name))])
    let parse xml =
      Some
        {
          d_b_subnet_group_name =
            (Xml.required "DBSubnetGroupName"
               (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
                  String.parse));
          d_b_subnet_group_description =
            (Util.option_bind (Xml.member "DBSubnetGroupDescription" xml)
               String.parse);
          subnet_ids =
            (Xml.required "SubnetIds"
               (Util.option_bind (Xml.member "SubnetIds" xml)
                  SubnetIdentifierList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBSubnetGroupName"
                   ([], (String.to_xml v.d_b_subnet_group_name)))])
            @
            [Util.option_map v.d_b_subnet_group_description
               (fun f ->
                  Ezxmlm.make_tag "DBSubnetGroupDescription"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SubnetIds"
                      ([], (SubnetIdentifierList.to_xml [x])))) v.subnet_ids))
  end[@@ocaml.doc "<p/>"]
module ModifyDBSubnetGroupResult = ModifyDBSubnetGroupResult
type input = ModifyDBSubnetGroupMessage.t
type output = ModifyDBSubnetGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyDBSubnetGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBSubnetGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyDBSubnetGroupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyDBSubnetGroupResponse" (snd xml))
        (Xml.member "ModifyDBSubnetGroupResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyDBSubnetGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyDBSubnetGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBSubnetGroupResult - missing field in body or children: "
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