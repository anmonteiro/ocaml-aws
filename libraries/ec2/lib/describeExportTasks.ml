open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeExportTasksRequest =
  struct
    type t =
      {
      export_task_ids: ExportTaskIdStringList.t
        [@ocaml.doc "<p>The export task IDs.</p>"];
      filters: FilterList.t }
    let make ?(export_task_ids= [])  ?(filters= [])  () =
      { export_task_ids; filters }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("ExportTaskId",
                  (ExportTaskIdStringList.to_query v.export_task_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filters", (FilterList.to_json v.filters));
           Some
             ("export_task_ids",
               (ExportTaskIdStringList.to_json v.export_task_ids))])
    let parse xml =
      Some
        {
          export_task_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "exportTaskId" xml)
                  ExportTaskIdStringList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "exportTaskId"
                       ([], (ExportTaskIdStringList.to_xml [x]))))
               v.export_task_ids))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
              v.filters))
  end
module DescribeExportTasksResult = DescribeExportTasksResult
type input = DescribeExportTasksRequest.t
type output = DescribeExportTasksResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeExportTasks"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeExportTasksRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeExportTasksRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeExportTasksResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeExportTasksResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeExportTasksResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeExportTasksResult - missing field in body or children: "
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