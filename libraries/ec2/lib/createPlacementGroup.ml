open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreatePlacementGroupRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      group_name: String.t option
        [@ocaml.doc
          "<p>A name for the placement group. Must be unique within the scope of your account for the Region.</p> <p>Constraints: Up to 255 ASCII characters</p>"];
      strategy: PlacementStrategy.t option
        [@ocaml.doc "<p>The placement strategy.</p>"];
      partition_count: Integer.t option
        [@ocaml.doc
          "<p>The number of partitions. Valid only when <b>Strategy</b> is set to <code>partition</code>.</p>"]}
    let make ?dry_run  ?group_name  ?strategy  ?partition_count  () =
      { dry_run; group_name; strategy; partition_count }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.partition_count
              (fun f -> Query.Pair ("PartitionCount", (Integer.to_query f)));
           Util.option_map v.strategy
             (fun f ->
                Query.Pair ("Strategy", (PlacementStrategy.to_query f)));
           Util.option_map v.group_name
             (fun f -> Query.Pair ("GroupName", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.partition_count
              (fun f -> ("partition_count", (Integer.to_json f)));
           Util.option_map v.strategy
             (fun f -> ("strategy", (PlacementStrategy.to_json f)));
           Util.option_map v.group_name
             (fun f -> ("group_name", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          group_name =
            (Util.option_bind (Xml.member "groupName" xml) String.parse);
          strategy =
            (Util.option_bind (Xml.member "strategy" xml)
               PlacementStrategy.parse);
          partition_count =
            (Util.option_bind (Xml.member "PartitionCount" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.group_name
                (fun f -> Ezxmlm.make_tag "groupName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.strategy
               (fun f ->
                  Ezxmlm.make_tag "strategy"
                    ([], (PlacementStrategy.to_xml f)))])
           @
           [Util.option_map v.partition_count
              (fun f ->
                 Ezxmlm.make_tag "PartitionCount" ([], (Integer.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CreatePlacementGroupRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["CreatePlacementGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreatePlacementGroupRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreatePlacementGroupRequest.to_headers req)),
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