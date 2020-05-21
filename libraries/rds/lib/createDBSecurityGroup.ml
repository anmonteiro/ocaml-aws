open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBSecurityGroupMessage =
  struct
    type t =
      {
      d_b_security_group_name: String.t
        [@ocaml.doc
          "<p>The name for the DB security group. This value is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> <li> <p>Must not be \"Default\"</p> </li> </ul> <p>Example: <code>mysecuritygroup</code> </p>"];
      d_b_security_group_description: String.t
        [@ocaml.doc "<p>The description for the DB security group.</p>"];
      tags: TagList.t
        [@ocaml.doc "<p>Tags to assign to the DB security group.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_security_group_name  ~d_b_security_group_description 
      ?(tags= [])  () =
      { d_b_security_group_name; d_b_security_group_description; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("d_b_security_group_description",
               (String.to_json v.d_b_security_group_description));
           Some
             ("d_b_security_group_name",
               (String.to_json v.d_b_security_group_name))])
    let parse xml =
      Some
        {
          d_b_security_group_name =
            (Xml.required "DBSecurityGroupName"
               (Util.option_bind (Xml.member "DBSecurityGroupName" xml)
                  String.parse));
          d_b_security_group_description =
            (Xml.required "DBSecurityGroupDescription"
               (Util.option_bind
                  (Xml.member "DBSecurityGroupDescription" xml) String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBSecurityGroupName"
                   ([], (String.to_xml v.d_b_security_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "DBSecurityGroupDescription"
                  ([], (String.to_xml v.d_b_security_group_description)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CreateDBSecurityGroupResult = CreateDBSecurityGroupResult
type input = CreateDBSecurityGroupMessage.t
type output = CreateDBSecurityGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateDBSecurityGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBSecurityGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateDBSecurityGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateDBSecurityGroupResponse" (snd xml))
        (Xml.member "CreateDBSecurityGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateDBSecurityGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateDBSecurityGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBSecurityGroupResult - missing field in body or children: "
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