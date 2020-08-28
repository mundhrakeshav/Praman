import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StudentSignInComponent } from './student-sign-in.component';

describe('StudentSignInComponent', () => {
  let component: StudentSignInComponent;
  let fixture: ComponentFixture<StudentSignInComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StudentSignInComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StudentSignInComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
