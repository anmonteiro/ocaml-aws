open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyOptionGroupMessage =
  struct
    type t =
      {
      option_group_name: String.t
        [@ocaml.doc
          "<p>The name of the option group to be modified.</p> <p>Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group, and that option group can't be removed from a DB instance once it is associated with a DB instance</p>"];
      options_to_include: OptionConfigurationList.t
        [@ocaml.doc
          "<p>Options in this list are added to the option group or, if already present, the specified configuration is used to update the existing configuration.</p>"];
      options_to_remove: OptionNamesList.t
        [@ocaml.doc
          "<p>Options in this list are removed from the option group.</p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to apply the change immediately or during the next maintenance window for each instance associated with the option group.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~option_group_name  ?(options_to_include= []) 
      ?(options_to_remove= [])  ?apply_immediately  () =
      {
        option_group_name;
        options_to_include;
        options_to_remove;
        apply_immediately
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.apply_immediately
              (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Some
             ("options_to_remove",
               (OptionNamesList.to_json v.options_to_remove));
           Some
             ("options_to_include",
               (OptionConfigurationList.to_json v.options_to_include));
           Some ("option_group_name", (String.to_json v.option_group_name))])
    let parse xml =
      Some
        {
          option_group_name =
            (Xml.required "OptionGroupName"
               (Util.option_bind (Xml.member "OptionGroupName" xml)
                  String.parse));
          options_to_include =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionsToInclude" xml)
                  OptionConfigurationList.parse));
          options_to_remove =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionsToRemove" xml)
                  OptionNamesList.parse));
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "OptionGroupName"
                    ([], (String.to_xml v.option_group_name)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "OptionsToInclude"
                        ([], (OptionConfigurationList.to_xml [x]))))
                v.options_to_include))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "OptionsToRemove"
                       ([], (OptionNamesList.to_xml [x]))))
               v.options_to_remove))
           @
           [Util.option_map v.apply_immediately
              (fun f ->
                 Ezxmlm.make_tag "ApplyImmediately" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module ModifyOptionGroupResult = ModifyOptionGroupResult
type input = ModifyOptionGroupMessage.t
type output = ModifyOptionGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyOptionGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyOptionGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyOptionGroupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyOptionGroupResponse" (snd xml))
        (Xml.member "ModifyOptionGroupResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyOptionGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyOptionGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyOptionGroupResult - missing field in body or children: "
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