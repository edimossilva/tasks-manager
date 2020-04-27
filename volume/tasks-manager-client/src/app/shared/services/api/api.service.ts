import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { AuthService } from '../auth/auth.service';
import { Tasklist } from 'src/app/model/tasklist';
import { Task } from 'src/app/model/task';

@Injectable({
  providedIn: 'root',
})
export class ApiService {
  constructor(private http: HttpClient, private authService: AuthService) {}
  // baseUrl = 'http://localhost:3000/';
  baseUrl = 'https://edimossilva-task-manager.herokuapp.com/';
  loginUrl = `${this.baseUrl}auth/login`;
  tasklistsUrl = `${this.baseUrl}task_lists`;
  taskWithTaskListUrl = `${this.baseUrl}task_with_task_list`;

  getHeaders() {
    const token = this.authService.getToken();
    return {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`,
      }),
    };
  }

  doLogin(username: string, password: string) {
    const body = {
      username,
      password,
    };
    return this.http.post<any>(this.loginUrl, body);
  }

  getTaskLists() {
    return this.http.get<any>(this.tasklistsUrl, this.getHeaders());
  }

  getTaskList(id: number) {
    const url = `${this.tasklistsUrl}/${id}`;

    return this.http.get<any>(url, this.getHeaders());
  }

  createTaskList(tasklist: Tasklist) {
    return this.http.post<any>(this.tasklistsUrl, tasklist, this.getHeaders());
  }

  createTaskInTaskList(task: Task, tasklistId: number) {
    const params = {
      name: task.name,
      description: task.description,
      task_list_id: tasklistId,
    };

    return this.http.post<any>(
      this.taskWithTaskListUrl,
      params,
      this.getHeaders()
    );
  }
}
