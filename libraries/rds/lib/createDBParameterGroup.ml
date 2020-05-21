open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBParameterGroupMessage =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB parameter group.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <note> <p>This value is stored as a lowercase string.</p> </note>"];
      d_b_parameter_group_family: String.t
        [@ocaml.doc
          "<p>The DB parameter group family name. A DB parameter group can be associated with one and only one DB parameter group family, and can be applied only to a DB instance running a database engine and engine version compatible with that DB parameter group family.</p> <p>To list all of the available parameter group families, use the following command:</p> <p> <code>aws rds describe-db-engine-versions --query \"DBEngineVersions[].DBParameterGroupFamily\"</code> </p> <note> <p>The output contains duplicates.</p> </note>"];
      description: String.t
        [@ocaml.doc "<p>The description for the DB parameter group.</p>"];
      tags: TagList.t
        [@ocaml.doc "<p>Tags to assign to the DB parameter group.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_parameter_group_name  ~d_b_parameter_group_family 
      ~description  ?(tags= [])  () =
      {
        d_b_parameter_group_name;
        d_b_parameter_group_family;
        description;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some ("description", (String.to_json v.description));
           Some
             ("d_b_parameter_group_family",
               (String.to_json v.d_b_parameter_group_family));
           Some
             ("d_b_parameter_group_name",
               (String.to_json v.d_b_parameter_group_name))])
    let parse xml =
      Some
        {
          d_b_parameter_group_name =
            (Xml.required "DBParameterGroupName"
               (Util.option_bind (Xml.member "DBParameterGroupName" xml)
                  String.parse));
          d_b_parameter_group_family =
            (Xml.required "DBParameterGroupFamily"
               (Util.option_bind (Xml.member "DBParameterGroupFamily" xml)
                  String.parse));
          description =
            (Xml.required "Description"
               (Util.option_bind (Xml.member "Description" xml) String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBParameterGroupName"
                    ([], (String.to_xml v.d_b_parameter_group_name)))])
             @
             [Some
                (Ezxmlm.make_tag "DBParameterGroupFamily"
                   ([], (String.to_xml v.d_b_parameter_group_family)))])
            @
            [Some
               (Ezxmlm.make_tag "Description"
                  ([], (String.to_xml v.description)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CreateDBParameterGroupResult = CreateDBParameterGroupResult
type input = CreateDBParameterGroupMessage.t
type output = CreateDBParameterGroupResult.t
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
         ("Action", ["CreateDBParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateDBParameterGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateDBParameterGroupResponse" (snd xml))
        (Xml.member "CreateDBParameterGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateDBParameterGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateDBParameterGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBParameterGroupResult - missing field in body or children: "
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