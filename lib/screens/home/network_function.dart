import 'package:flutter/material.dart';
import 'package:q_flow_company/model/bookmarks/bookmarked_visitor.dart';
import 'package:q_flow_company/screens/home/home_cubit.dart';
import 'package:q_flow_company/supabase/supabase_company.dart';
import 'package:q_flow_company/supabase/supabase_interview.dart';

import '../../supabase/supabase_bookmark.dart';

extension NetworkFunctions on HomeCubit {
  Future fetchInterviews() async {
    try {
      emitLoading();
      var response = await SupabaseInterview.fetchInterviews();
      return response;
    } catch (e) {
      emitError("Error loading interviews:\n${e.toString()}");
    }
  }

  Future fetchCompanyDetails() async {
    try {
      emitLoading();
      var response = await SupabaseCompany.fetchCompany();
      return response;
    } catch (e) {
      emitError("Error loading company details:\n${e.toString()}");
    }
  }

  Future updateCompany(BuildContext context, bool currentQueueStatus) async {
    var company = dataMgr.company;

    try {
      emitLoading();
      if (company == null) throw Exception('');
      company.isQueueOpen = currentQueueStatus;

      await SupabaseCompany.updateCompany(
          imageFile: null, company: company, companyId: company.id ?? '');

      dataMgr.saveCompanyData(company: company);
    } catch (e) {
      emitError(
          'Could not update event!\nPlease try again later.\n${e.toString()}');
    }
  }

  // Bookmarks

  fetchBookmarks(BuildContext context) async {
    try {
      emitLoading();
      var bookmarks = await SupabaseBookmark.fetchBookmarks();
      company.bookmarkedVisitors = bookmarks;
      dataMgr.company = company;
      emitUpdate();
      return bookmarks;
    } catch (e) {
      emitError(e.toString());
    }
  }

  createBookmark(BuildContext context, String visitorId) async {
    try {
      emitLoading();
      await SupabaseBookmark.createBookmark(visitorId);
      company.bookmarkedVisitors
          ?.add(BookmarkedVisitor(visitorId: visitorId, companyId: company.id));
      dataMgr.company = company;
      emitUpdate();
    } catch (e) {
      emitError(e.toString());
    }
  }

  deleteBookmark(BuildContext context, String visitorId) async {
    try {
      emitLoading();
      await SupabaseBookmark.deleteBookmark(visitorId);
      company.bookmarkedVisitors
          ?.removeWhere((bm) => bm.visitorId == visitorId);
      dataMgr.company = company;
      filterVisitors();
    } catch (e) {
      emitError(e.toString());
    }
  }
}
