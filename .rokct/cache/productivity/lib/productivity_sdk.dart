// Copyright (c) 2026 ROKCT INTELLIGENCE (PTY) LTD
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

library productivity_sdk;

export 'src/common/domain/interface/todo_repository_facade.dart';
export 'src/common/domain/interface/recovery_repository_facade.dart';
export 'src/common/infrastructure/database/tasks_table.dart';
export 'src/common/infrastructure/database/recovery_tables.dart';
export 'src/common/infrastructure/repositories/todo_repository_impl.dart';
export 'src/common/infrastructure/repositories/recovery_repository_impl.dart';
export 'src/common/infrastructure/services/task_service.dart';
export 'src/common/models/data/task_data.dart';
export 'src/common/models/request/task_request.dart';
export 'src/common/models/response/task_response.dart';
export 'src/common/application/recovery/recovery_state.dart';
export 'src/common/application/recovery/recovery_notifier.dart';
export 'src/common/application/recovery/recovery_provider.dart';
export 'src/common/di/productivity_di.dart';
