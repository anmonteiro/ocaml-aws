open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBSubnetGroupMessage =
  struct
    type t =
      {
      d_b_subnet_group_name: String.t
        [@ocaml.doc
          "<p>The name for the DB subnet group. This value is stored as a lowercase string.</p> <p>Constraints: Must contain no more than 255 letters, numbers, periods, underscores, spaces, or hyphens. Must not be default.</p> <p>Example: <code>mySubnetgroup</code> </p>"];
      d_b_subnet_group_description: String.t
        [@ocaml.doc "<p>The description for the DB subnet group.</p>"];
      subnet_ids: SubnetIdentifierList.t
        [@ocaml.doc "<p>The EC2 Subnet IDs for the DB subnet group.</p>"];
      tags: TagList.t
        [@ocaml.doc "<p>Tags to assign to the DB subnet group.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_subnet_group_name  ~d_b_subnet_group_description 
      ~subnet_ids  ?(tags= [])  () =
      { d_b_subnet_group_name; d_b_subnet_group_description; subnet_ids; tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some ("subnet_ids", (SubnetIdentifierList.to_json v.subnet_ids));
           Some
             ("d_b_subnet_group_description",
               (String.to_json v.d_b_subnet_group_description));
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
            (Xml.required "DBSubnetGroupDescription"
               (Util.option_bind (Xml.member "DBSubnetGroupDescription" xml)
                  String.parse));
          subnet_ids =
            (Xml.required "SubnetIds"
               (Util.option_bind (Xml.member "SubnetIds" xml)
                  SubnetIdentifierList.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBSubnetGroupName"
                    ([], (String.to_xml v.d_b_subnet_group_name)))])
             @
             [Some
                (Ezxmlm.make_tag "DBSubnetGroupDescription"
                   ([], (String.to_xml v.d_b_subnet_group_description)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "SubnetIds"
                       ([], (SubnetIdentifierList.to_xml [x])))) v.subnet_ids))
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CreateDBSubnetGroupResult = CreateDBSubnetGroupResult
type input = CreateDBSubnetGroupMessage.t
type output = CreateDBSubnetGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateDBSubnetGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBSubnetGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateDBSubnetGroupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateDBSubnetGroupResponse" (snd xml))
        (Xml.member "CreateDBSubnetGroupResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateDBSubnetGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateDBSubnetGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBSubnetGroupResult - missing field in body or children: "
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