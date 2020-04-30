import { Tasklist } from 'src/app/model/tasklist';
import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class TasklistStoreService {
  private readonly _tasklists = new BehaviorSubject<Tasklist[]>([]);
  readonly tasklists$ = this._tasklists.asObservable();

  get tasklists(): Tasklist[] {
    return this._tasklists.getValue();
  }

  set tasklists(val: Tasklist[]) {
    this._tasklists.next(val);
  }

  addTasklist(tasklist: Tasklist) {
    this.tasklists = [...this.tasklists, tasklist];
  }

  removeTasklist(id: number) {
    this.tasklists = this.tasklists.filter((tasklist) => tasklist.id !== id);
  }

  getTasklist(id: number): Tasklist {
    return this.tasklists.filter((tasklist) => tasklist.id === id)[0];
  }
}
