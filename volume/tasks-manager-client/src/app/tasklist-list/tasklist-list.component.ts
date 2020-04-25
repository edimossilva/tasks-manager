import { Component, OnInit } from '@angular/core';
import { ApiService } from '../shared/services/api/api.service';

@Component({
  selector: 'app-tasklist-list',
  templateUrl: './tasklist-list.component.html',
  styleUrls: ['./tasklist-list.component.css'],
})
export class TasklistListComponent implements OnInit {
  constructor(private api: ApiService) {}

  ngOnInit(): void {
    this.api.getTaskLists().subscribe();
  }
}
