open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ResetImageAttributeRequest =
  struct
    type t =
      {
      attribute: ResetImageAttributeName.t
        [@ocaml.doc
          "<p>The attribute to reset (currently you can only reset the launch permission attribute).</p>"];
      image_id: String.t [@ocaml.doc "<p>The ID of the AMI.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for ResetImageAttribute.</p>"]
    let make ~attribute  ~image_id  ?dry_run  () =
      { attribute; image_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("ImageId", (String.to_query v.image_id)));
           Some
             (Query.Pair
                ("Attribute", (ResetImageAttributeName.to_query v.attribute)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("image_id", (String.to_json v.image_id));
           Some ("attribute", (ResetImageAttributeName.to_json v.attribute))])
    let parse xml =
      Some
        {
          attribute =
            (Xml.required "Attribute"
               (Util.option_bind (Xml.member "Attribute" xml)
                  ResetImageAttributeName.parse));
          image_id =
            (Xml.required "ImageId"
               (Util.option_bind (Xml.member "ImageId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "Attribute"
                   ([], (ResetImageAttributeName.to_xml v.attribute)))])
            @
            [Some
               (Ezxmlm.make_tag "ImageId" ([], (String.to_xml v.image_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for ResetImageAttribute.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ResetImageAttributeRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ResetImageAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ResetImageAttributeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ResetImageAttributeRequest.to_headers req)),
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