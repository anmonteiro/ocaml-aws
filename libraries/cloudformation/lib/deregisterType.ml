open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeregisterTypeInput =
  struct
    type t =
      {
      arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the type.</p> <p>Conditional: You must specify <code>TypeName</code> or <code>Arn</code>.</p>"];
      type_: RegistryType.t option
        [@ocaml.doc
          "<p>The kind of type.</p> <p>Currently the only valid value is <code>RESOURCE</code>.</p>"];
      type_name: String.t option
        [@ocaml.doc
          "<p>The name of the type.</p> <p>Conditional: You must specify <code>TypeName</code> or <code>Arn</code>.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>The ID of a specific version of the type. The version ID is the value at the end of the Amazon Resource Name (ARN) assigned to the type version when it is registered.</p>"]}
    let make ?arn  ?type_  ?type_name  ?version_id  () =
      { arn; type_; type_name; version_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (RegistryType.to_json f)));
           Util.option_map v.arn (fun f -> ("arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          arn = (Util.option_bind (Xml.member "Arn" xml) String.parse);
          type_ =
            (Util.option_bind (Xml.member "Type" xml) RegistryType.parse);
          type_name =
            (Util.option_bind (Xml.member "TypeName" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.arn
                 (fun f -> Ezxmlm.make_tag "Arn" ([], (String.to_xml f)))])
             @
             [Util.option_map v.type_
                (fun f ->
                   Ezxmlm.make_tag "Type" ([], (RegistryType.to_xml f)))])
            @
            [Util.option_map v.type_name
               (fun f -> Ezxmlm.make_tag "TypeName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = DeregisterTypeInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DeregisterType"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeregisterTypeInput.to_query req))))) in
  (`POST, uri, (Headers.render (DeregisterTypeInput.to_headers req)), "")
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